/*
 * top - a top users display for Unix
 *
 * SYNOPSIS:  For DragonFly 1.2 and later
 *
 * DESCRIPTION:
 * Originally written for BSD4.4 system by Christos Zoulas.
 * Ported to FreeBSD 2.x by Steven Wallace && Wolfram Schneider
 * Order support hacked in from top-3.5beta6/machine/m_aix41.c
 *   by Monte Mitzelfelt (for latest top see http://www.groupsys.com/topinfo/)
 *
 * LIBS: -lkvm
 *
 * AUTHOR:  Christos Zoulas <christos@ee.cornell.edu>
 *          Steven Wallace  <swallace@freebsd.org>
 *          Wolfram Schneider <wosch@FreeBSD.org>
 *          Hiten Pandya <hmp@backplane.com>
 *
 * $NetBSD: m_dragonfly.c,v 1.2 2007/07/02 09:48:24 joerg Exp $
 * $DragonFly: src/usr.bin/top/machine.c,v 1.18 2005/11/14 18:50:18 dillon Exp $
 */


#include <sys/time.h>
#include <sys/types.h>
#include <sys/signal.h>
#include <sys/param.h>

#include "os.h"
#include <err.h>
#include <kvm.h>
#include <stdio.h>
#include <math.h>
#include <pwd.h>
#include <sys/errno.h>
#include <sys/sysctl.h>
#include <sys/file.h>
#include <sys/time.h>
#include <sys/user.h>
#include <sys/vmmeter.h>
#include <sys/resource.h>
#include <sys/rtprio.h>

/* Swap */
#include <stdlib.h>
#include <sys/conf.h>

#include <osreldate.h> /* for changes in kernel structures */

#include <sys/kinfo.h>
#include <kinfo.h>
#include "top.h"
#include "machine.h"

static int check_nlist(struct nlist *);
static int getkval(unsigned long, int *, int, char *);
extern char* printable(char *);
int swapmode(int *retavail, int *retfree);
static int smpmode;
static int namelength;
static int cmdlength;

/* get_process_info passes back a handle.  This is what it looks like: */

struct handle
{
    struct kinfo_proc **next_proc;	/* points to next valid proc pointer */
    int remaining;		/* number of pointers remaining */
};

/* declarations for load_avg */
#include "loadavg.h"

#define PP(pp, field) ((pp)->kp_proc . field)
#define EP(pp, field) ((pp)->kp_eproc . field)
#define TP(pp, field) ((pp)->kp_thread . field)
#define VP(pp, field) ((pp)->kp_eproc.e_vm . field)

/* define what weighted cpu is.  */
#define weighted_cpu(pct, pp) (PP((pp), p_swtime) == 0 ? 0.0 : \
			 ((pct) / (1.0 - exp(PP((pp), p_swtime) * logcpu))))

/* what we consider to be process size: */
#define PROCSIZE(pp) (VP((pp), vm_map.size) / 1024)

/*
 *  These definitions control the format of the per-process area
 */

static char smp_header[] =
  "  PID %-*.*s PRI NICE  SIZE    RES STATE  C   TIME   WCPU    CPU COMMAND";

#define smp_Proc_format \
	"%5d %-*.*s %3d %3d%7s %6s %-6.6s %1x%7s %5.2f%% %5.2f%% %.*s"

static char up_header[] =
  "  PID %-*.*s PRI NICE  SIZE    RES STATE    TIME   WCPU    CPU COMMAND";

#define up_Proc_format \
	"%5d %-*.*s %3d %3d%7s %6s %-6.6s%.0d%7s %5.2f%% %5.2f%% %.*s"



/* process state names for the "STATE" column of the display */
/* the extra nulls in the string "run" are for adding a slash and
   the processor number when needed */

char *state_abbrev[] =
{
    "", "START", "RUN\0\0\0", "SLEEP", "STOP", "ZOMB",
};


static kvm_t *kd;

/* values that we stash away in _init and use in later routines */

static double logcpu;

static long lastpid;
static long cnt;
static int ccpu;

/* these are for calculating cpu state percentages */

static struct kinfo_cputime cp_time, cp_old;

/* these are for detailing the process states */

int process_states[6];
char *procstatenames[] = {
    "", " starting, ", " running, ", " sleeping, ", " stopped, ",
    " zombie, ",
    NULL
};

/* these are for detailing the cpu states */
#define CPU_STATES 5
int cpu_states[CPU_STATES];
char *cpustatenames[CPU_STATES + 1] = {
    "user", "nice", "system", "interrupt", "idle", NULL
};

/* these are for detailing the memory statistics */

int memory_stats[7];
char *memorynames[] = {
    "K Active, ", "K Inact, ", "K Wired, ", "K Cache, ", "K Buf, ", "K Free",
    NULL
};

int swap_stats[7];
char *swapnames[] = {
/*   0           1            2           3            4       5 */
    "K Total, ", "K Used, ", "K Free, ", "% Inuse, ", "K In, ", "K Out",
    NULL
};


/* these are for keeping track of the proc array */

static int nproc;
static int onproc = -1;
static int pref_len;
static struct kinfo_proc *pbase;
static struct kinfo_proc **pref;

/* these are for getting the memory statistics */

static int pageshift;		/* log base 2 of the pagesize */

/* define pagetok in terms of pageshift */

#define pagetok(size) ((size) << pageshift)

/* sorting orders. first is default */
char *ordernames[] = {
    "cpu", "size", "res", "time", "pri", NULL
};

/* compare routines */
int proc_compare(), compare_size(), compare_res(), compare_time(), compare_prio();

int (*proc_compares[])() = {
    proc_compare,
    compare_size,
    compare_res,
    compare_time,
    compare_prio,
    NULL
};

static void
cputime_percentages(int out[CPU_STATES], struct kinfo_cputime *new,
		    struct kinfo_cputime *old)
{
        struct kinfo_cputime diffs;
        int i;
	uint64_t total_change, half_total;

        /* initialization */
	total_change = 0;

        diffs.cp_user = new->cp_user - old->cp_user;
	diffs.cp_nice = new->cp_nice - old->cp_nice;
	diffs.cp_sys = new->cp_sys - old->cp_sys;
        diffs.cp_intr = new->cp_intr - old->cp_intr;
        diffs.cp_idle = new->cp_idle - old->cp_idle;
	total_change = diffs.cp_user + diffs.cp_nice + diffs.cp_sys +
    	    diffs.cp_intr + diffs.cp_idle;
        old->cp_user = new->cp_user;
        old->cp_nice = new->cp_nice;
        old->cp_sys = new->cp_sys;
        old->cp_intr = new->cp_intr;
	old->cp_idle = new->cp_idle;

        /* avoid divide by zero potential */
	if (total_change == 0)
		total_change = 1;

	/* calculate percentages based on overall change, rounding up */
        half_total = total_change >> 1;

	out[0] = ((diffs.cp_user * 1000LL + half_total) / total_change);
        out[1] = ((diffs.cp_nice * 1000LL + half_total) / total_change);
	out[2] = ((diffs.cp_sys * 1000LL + half_total) / total_change);
        out[3] = ((diffs.cp_intr * 1000LL + half_total) / total_change);
	out[4] = ((diffs.cp_idle * 1000LL + half_total) / total_change);
}

int
machine_init(struct statics *statics)
{
    register int i = 0;
    register int pagesize;
    size_t modelen;
    struct passwd *pw;
    struct timeval boottime;
    int mib[2];
    size_t bt_size;

    modelen = sizeof(smpmode);
    if ((sysctlbyname("machdep.smp_active", &smpmode, &modelen, NULL, 0) < 0 &&
         sysctlbyname("smp.smp_active", &smpmode, &modelen, NULL, 0) < 0) ||
	modelen != sizeof(smpmode))
	    smpmode = 0;

    while ((pw = getpwent()) != NULL) {
	if (strlen(pw->pw_name) > namelength)
	    namelength = strlen(pw->pw_name);
    }
    if (namelength < 8)
	namelength = 8;
    if (smpmode && namelength > 13)
	namelength = 13;
    else if (namelength > 15)
	namelength = 15;

    if ((kd = kvm_open(NULL, NULL, NULL, O_RDONLY, "kvm_open")) == NULL)
	return -1;

    if (kinfo_get_sched_ccpu(&ccpu)) {
	fprintf(stderr, "top: kinfo_get_sched_ccpu failed\n");
	return(-1);
    }

    /* this is used in calculating WCPU -- calculate it ahead of time */
    logcpu = log(loaddouble(ccpu));

    pbase = NULL;
    pref = NULL;
    nproc = 0;
    onproc = -1;
    /* get the page size with "getpagesize" and calculate pageshift from it */
    pagesize = getpagesize();
    pageshift = 0;
    while (pagesize > 1)
    {
	pageshift++;
	pagesize >>= 1;
    }

    /* we only need the amount of log(2)1024 for our conversion */
    pageshift -= LOG1024;

    /* fill in the statics information */
    statics->procstate_names = procstatenames;
    statics->cpustate_names = cpustatenames;
    statics->memory_names = memorynames;
    statics->swap_names = swapnames;
    statics->order_names = ordernames;

    /*
     * Print how long system has been up.
     * (Found by looking getting "boottime" from the kernel)
     */
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    bt_size = sizeof(boottime);
    if (sysctl(mib, 2, &boottime, &bt_size, NULL, 0) != -1 &&
	boottime.tv_sec != 0) {
	statics->boottime = boottime.tv_sec;
    }

    /* all done! */
    return(0);
}

char *format_header(register char *uname_field)
{
    register char *ptr;
    static char Header[128];

    snprintf(Header, sizeof(Header), smpmode ? smp_header : up_header,
	     namelength, namelength, uname_field);

    if (screen_width <= 79)
    	cmdlength = 80;
    else
	cmdlength = 89;

    cmdlength = cmdlength - strlen(Header) + 6;

    return Header;
}

static int swappgsin = -1;
static int swappgsout = -1;
extern struct timeval timeout;

void
get_system_info(struct system_info *si)
{
    long total;

    if (kinfo_get_sched_cputime(&cp_time))
	err(1, "kinfo_get_sched_cputime failed");

    getloadavg(si->load_avg, 3);

    lastpid = 0;

    /* convert cp_time counts to percentages */
    cputime_percentages(cpu_states, &cp_time, &cp_old);

    /* sum memory & swap statistics */
    {
	struct vmmeter vmm;
	struct vmstats vms;
	int vms_size = sizeof(vms);
	int vmm_size = sizeof(vmm);
	static unsigned int swap_delay = 0;
	static int swapavail = 0;
	static int swapfree = 0;
	static int bufspace = 0;

	if (sysctlbyname("vm.vmstats", &vms, &vms_size, NULL, 0))
		err(1, "sysctlbyname: vm.vmstats");

	if (sysctlbyname("vm.vmmeter", &vmm, &vmm_size, NULL, 0))
		err(1, "sysctlbyname: vm.vmmeter");

	if (kinfo_get_vfs_bufspace(&bufspace))
		err(1, "kinfo_get_vfs_bufspace");

	/* convert memory stats to Kbytes */
	memory_stats[0] = pagetok(vms.v_active_count);
	memory_stats[1] = pagetok(vms.v_inactive_count);
	memory_stats[2] = pagetok(vms.v_wire_count);
	memory_stats[3] = pagetok(vms.v_cache_count);
	memory_stats[4] = bufspace / 1024;
	memory_stats[5] = pagetok(vms.v_free_count);
	memory_stats[6] = -1;

	/* first interval */
        if (swappgsin < 0) {
	    swap_stats[4] = 0;
	    swap_stats[5] = 0;
	} 

	/* compute differences between old and new swap statistic */
	else {
	    swap_stats[4] = pagetok(((vmm.v_swappgsin - swappgsin)));
	    swap_stats[5] = pagetok(((vmm.v_swappgsout - swappgsout)));
	}

        swappgsin = vmm.v_swappgsin;
	swappgsout = vmm.v_swappgsout;

	/* call CPU heavy swapmode() only for changes */
        if (swap_stats[4] > 0 || swap_stats[5] > 0 || swap_delay == 0) {
	    swap_stats[3] = swapmode(&swapavail, &swapfree);
	    swap_stats[0] = swapavail;
	    swap_stats[1] = swapavail - swapfree;
	    swap_stats[2] = swapfree;
	}
        swap_delay = 1;
	swap_stats[6] = -1;
    }

    /* set arrays and strings */
    si->cpustates = cpu_states;
    si->memory = memory_stats;
    si->swap = swap_stats;


    if(lastpid > 0) {
	si->last_pid = lastpid;
    } else {
	si->last_pid = -1;
    }
}

static struct handle handle;

caddr_t get_process_info(struct system_info *si, struct process_select *sel,
                         int compare_index)
{
    register int i;
    register int total_procs;
    register int active_procs;
    register struct kinfo_proc **prefp;
    register struct kinfo_proc *pp;

    /* these are copied out of sel for speed */
    int show_idle;
    int show_self;
    int show_system;
    int show_uid;
    
    pbase = kvm_getprocs(kd, KERN_PROC_ALL, 0, &nproc);
    if (nproc > onproc)
	pref = (struct kinfo_proc **) realloc(pref, sizeof(struct kinfo_proc *)
		* (onproc = nproc));
    if (pref == NULL || pbase == NULL) {
	(void) fprintf(stderr, "top: Out of memory.\n");
	quit(23);
    }
    /* get a pointer to the states summary array */
    si->procstates = process_states;

    /* set up flags which define what we are going to select */
    show_idle = sel->idle;
    show_self = 0;
    show_system = sel->system;
    show_uid = sel->uid != -1;

    /* count up process states and get pointers to interesting procs */
    total_procs = 0;
    active_procs = 0;
    memset((char *)process_states, 0, sizeof(process_states));
    prefp = pref;
    for (pp = pbase, i = 0; i < nproc; pp++, i++)
    {
	/*
	 *  Place pointers to each valid proc structure in pref[].
	 *  Process slots that are actually in use have a non-zero
	 *  status field.  Processes with P_SYSTEM set are system
	 *  processes---these get ignored unless show_sysprocs is set.
	 */
	if (((show_self != PP(pp, p_pid)) &&
	    (show_system || ((PP(pp, p_flag) & P_SYSTEM) == 0))))
	{
	    total_procs++;
	    process_states[(unsigned char) PP(pp, p_stat)]++;
	    if (((show_idle || (PP(pp, p_pctcpu) != 0) ||
		 (PP(pp, p_stat) == SRUN)) &&
		(!show_uid || EP(pp, e_ucred.cr_ruid) == (uid_t)sel->uid)))
	    {
		*prefp++ = pp;
		active_procs++;
	    }
	}
    }

    qsort((char *)pref, active_procs, sizeof(struct kinfo_proc *),
	  proc_compares[compare_index]);

    /* remember active and total counts */
    si->p_total = total_procs;
    si->p_active = pref_len = active_procs;

    /* pass back a handle */
    handle.next_proc = pref;
    handle.remaining = active_procs;
    return((caddr_t)&handle);
}

char fmt[128];		/* static area where result is built */

char *format_next_process(caddr_t handle, char *(*get_userid)())
{
    struct kinfo_proc *pp;
    long cputime;
    double pct;
    struct handle *hp;
    char status[16];
    char const *wrapper;
    int state;
    int nice;

    /* find and remember the next proc structure */
    hp = (struct handle *)handle;
    pp = *(hp->next_proc++);
    hp->remaining--;
    
    /* set the wrapper for the process/thread name */
    if ((PP(pp, p_flag) & P_SWAPPEDOUT))
	 wrapper = "[]"; /* swapped process [pname] */
    else if (((PP(pp, p_flag) & P_SYSTEM) != 0) && (TP(pp, td_proc) != NULL))
	 wrapper = "()"; /* system process (pname) */
    else
	 wrapper = NULL;
  
    /* get the process's command name */
    if (wrapper != NULL) {
	char *comm = TP(pp, td_comm);
#define COMSIZ sizeof(TP(pp, td_comm))
	char buf[COMSIZ];
	(void) strncpy(buf, comm, COMSIZ);
	comm[0] = wrapper[0];
	(void) strncpy(&comm[1], buf, COMSIZ - 2);
	comm[COMSIZ - 2] = '\0';
	(void) strncat(comm, &wrapper[1], COMSIZ - 1);
	comm[COMSIZ - 1] = '\0';
    }

    /*
     * Convert the process's runtime from microseconds to seconds.  This
     * time includes the interrupt time although that is not wanted here.
     * ps(1) is similarly sloppy.
     */
    cputime = (EP(pp, e_uticks) + EP(pp, e_sticks)) / 1000000;

    /* calculate the base for cpu percentages */
    pct = pctdouble(PP(pp, p_pctcpu));

    /* generate "STATE" field */
    switch (state = PP(pp, p_stat)) {
	case SRUN:
	    if (smpmode && TP(pp, td_flags) & TDF_RUNNING)
		sprintf(status, "CPU%d", EP(pp, e_cpuid));
	    else
		strcpy(status, "RUN");
	    break;
	case SSLEEP:
	    if (TP(pp, td_wmesg) != NULL) {
		sprintf(status, "%.6s", EP(pp, e_wmesg));
		break;
	    }
	    /* fall through */
	default:

	    if (state >= 0 &&
	        state < sizeof(state_abbrev) / sizeof(*state_abbrev))
		    sprintf(status, "%.6s", state_abbrev[(unsigned char) state]);
	    else
		    sprintf(status, "?%5d", state);
	    break;
    }

    /*
     * idle time 0 - 31 -> nice value +21 - +52
     * normal time      -> nice value -20 - +20 
     * real time 0 - 31 -> nice value -52 - -21
     * thread    0 - 31 -> nice value -53 -
     */
    switch(PP(pp, p_rtprio.type)) {
    case RTP_PRIO_REALTIME:
	nice = PRIO_MIN - 1 - RTP_PRIO_MAX + PP(pp, p_rtprio.prio);
	break;
    case RTP_PRIO_IDLE:
	nice = PRIO_MAX + 1 + PP(pp, p_rtprio.prio);
	break;
    case RTP_PRIO_THREAD:
	nice = PRIO_MIN - 1 - RTP_PRIO_MAX - PP(pp, p_rtprio.prio);
	break;
    default:
	nice = PP(pp, p_nice);
	break;
    }


    /* format this entry */
    snprintf(fmt, sizeof(fmt),
	    smpmode ? smp_Proc_format : up_Proc_format,
	    PP(pp, p_pid),
	    namelength, namelength,
	    (*get_userid)(EP(pp, e_ucred.cr_ruid)),
	    PP(pp, p_usdata.bsd4.priority),
	    nice,
	    format_k(PROCSIZE(pp)),
	    format_k(pagetok(VP(pp, vm_rssize))),
	    status,
	    smpmode ? EP(pp, e_cpuid) : 0,
	    format_time(cputime),
	    100.0 * weighted_cpu(pct, pp),
	    100.0 * pct,
	    cmdlength,
	    printable(TP(pp, td_comm)));

    /* return the result */
    return(fmt);
}


/*
 * check_nlist(nlst) - checks the nlist to see if any symbols were not
 *		found.  For every symbol that was not found, a one-line
 *		message is printed to stderr.  The routine returns the
 *		number of symbols NOT found.
 */

static int check_nlist(register struct nlist *nlst)
{
    register int i;

    /* check to see if we got ALL the symbols we requested */
    /* this will write one line to stderr for every symbol not found */

    i = 0;
    while (nlst->n_name != NULL)
    {
	if (nlst->n_type == 0)
	{
	    /* this one wasn't found */
	    (void) fprintf(stderr, "kernel: no symbol named `%s'\n",
			   nlst->n_name);
	    i = 1;
	}
	nlst++;
    }

    return(i);
}

/* comparison routines for qsort */

/*
 *  proc_compare - comparison function for "qsort"
 *	Compares the resource consumption of two processes using five
 *  	distinct keys.  The keys (in descending order of importance) are:
 *  	percent cpu, cpu ticks, state, resident set size, total virtual
 *  	memory usage.  The process states are ordered as follows (from least
 *  	to most important):  WAIT, zombie, sleep, stop, start, run.  The
 *  	array declaration below maps a process state index into a number
 *  	that reflects this ordering.
 */

static unsigned char sorted_state[] =
{
    0,	/* not used		*/
    3,	/* sleep		*/
    1,	/* ABANDONED (WAIT)	*/
    6,	/* run			*/
    5,	/* start		*/
    2,	/* zombie		*/
    4	/* stop			*/
};
 

#define ORDERKEY_PCTCPU \
  if (lresult = (long) PP(p2, p_pctcpu) - (long) PP(p1, p_pctcpu), \
     (result = lresult > 0 ? 1 : lresult < 0 ? -1 : 0) == 0)

#define CPTICKS(p)	(EP(p, e_uticks) + EP(p, e_sticks))

#define ORDERKEY_CPTICKS \
  if ((result = CPTICKS(p2) > CPTICKS(p1) ? 1 : \
		CPTICKS(p2) < CPTICKS(p1) ? -1 : 0) == 0)

#define ORDERKEY_STATE \
  if ((result = sorted_state[(unsigned char) PP(p2, p_stat)] - \
                sorted_state[(unsigned char) PP(p1, p_stat)]) == 0)

#define ORDERKEY_PRIO \
  if ((result = PP(p2, p_usdata.bsd4.priority) - PP(p1, p_usdata.bsd4.priority)) == 0)

#define ORDERKEY_KTHREADS \
  if ((result = (TP(p1, td_proc) == NULL) - (TP(p2, td_proc) == NULL)) == 0)

#define ORDERKEY_KTHREADS_PRIO \
  if ((result = TP(p2, td_pri) - TP(p1, td_pri)) == 0)

#define ORDERKEY_RSSIZE \
  if ((result = VP(p2, vm_rssize) - VP(p1, vm_rssize)) == 0) 

#define ORDERKEY_MEM \
  if ( (result = PROCSIZE(p2) - PROCSIZE(p1)) == 0 )

/* compare_cpu - the comparison function for sorting by cpu percentage */

int
proc_compare(struct proc **pp1, struct proc **pp2)
{
    register struct kinfo_proc *p1;
    register struct kinfo_proc *p2;
    register int result;
    register pctcpu lresult;

    /* remove one level of indirection */
    p1 = *(struct kinfo_proc **) pp1;
    p2 = *(struct kinfo_proc **) pp2;

    ORDERKEY_PCTCPU
    ORDERKEY_CPTICKS
    ORDERKEY_STATE
    ORDERKEY_PRIO
    ORDERKEY_RSSIZE
    ORDERKEY_MEM
    ;

    return(result);
}

/* compare routines */

/* compare_size - the comparison function for sorting by total memory usage */

int
compare_size(struct proc **pp1, struct proc **pp2)
{
    register struct kinfo_proc *p1;
    register struct kinfo_proc *p2;
    register int result;
    register pctcpu lresult;

    /* remove one level of indirection */
    p1 = *(struct kinfo_proc **) pp1;
    p2 = *(struct kinfo_proc **) pp2;

    ORDERKEY_MEM
    ORDERKEY_RSSIZE
    ORDERKEY_PCTCPU
    ORDERKEY_CPTICKS
    ORDERKEY_STATE
    ORDERKEY_PRIO
    ;

    return(result);
}

/* compare_res - the comparison function for sorting by resident set size */

int
compare_res(struct proc **pp1, struct proc **pp2)
{
    register struct kinfo_proc *p1;
    register struct kinfo_proc *p2;
    register int result;
    register pctcpu lresult;

    /* remove one level of indirection */
    p1 = *(struct kinfo_proc **) pp1;
    p2 = *(struct kinfo_proc **) pp2;

    ORDERKEY_RSSIZE
    ORDERKEY_MEM
    ORDERKEY_PCTCPU
    ORDERKEY_CPTICKS
    ORDERKEY_STATE
    ORDERKEY_PRIO
    ;

    return(result);
}

/* compare_time - the comparison function for sorting by total cpu time */

int
compare_time(struct proc **pp1, struct proc **pp2)
{
    register struct kinfo_proc *p1;
    register struct kinfo_proc *p2;
    register int result;
    register pctcpu lresult;
  
    /* remove one level of indirection */
    p1 = *(struct kinfo_proc **) pp1;
    p2 = *(struct kinfo_proc **) pp2;

    ORDERKEY_CPTICKS
    ORDERKEY_PCTCPU
    ORDERKEY_KTHREADS
    ORDERKEY_KTHREADS_PRIO
    ORDERKEY_STATE
    ORDERKEY_PRIO
    ORDERKEY_RSSIZE
    ORDERKEY_MEM
    ;

      return(result);
  }
  
/* compare_prio - the comparison function for sorting by cpu percentage */

int
compare_prio(struct proc **pp1, struct proc **pp2)
{
    register struct kinfo_proc *p1;
    register struct kinfo_proc *p2;
    register int result;
    register pctcpu lresult;

    /* remove one level of indirection */
    p1 = *(struct kinfo_proc **) pp1;
    p2 = *(struct kinfo_proc **) pp2;

    ORDERKEY_KTHREADS
    ORDERKEY_KTHREADS_PRIO
    ORDERKEY_PRIO
    ORDERKEY_CPTICKS
    ORDERKEY_PCTCPU
    ORDERKEY_STATE
    ORDERKEY_RSSIZE
    ORDERKEY_MEM
    ;

    return(result);
}

/*
 * proc_owner(pid) - returns the uid that owns process "pid", or -1 if
 *		the process does not exist.
 *		It is EXTREMLY IMPORTANT that this function work correctly.
 *		If top runs setuid root (as in SVR4), then this function
 *		is the only thing that stands in the way of a serious
 *		security problem.  It validates requests for the "kill"
 *		and "renice" commands.
 */

int proc_owner(int pid)
{
    register int cnt;
    register struct kinfo_proc **prefp;
    register struct kinfo_proc *pp;

    prefp = pref;
    cnt = pref_len;
    while (--cnt >= 0)
    {
	pp = *prefp++;	
	if (PP(pp, p_pid) == (pid_t)pid)
	{
	    return((int)EP(pp, e_ucred.cr_ruid));
	}
    }
    return(-1);
}


/*
 * swapmode is based on a program called swapinfo written
 * by Kevin Lahey <kml@rokkaku.atl.ga.us>.
 */
int
swapmode(int *retavail, int *retfree)
{
	int n;
	int pagesize = getpagesize();
	struct kvm_swap swapary[1];

	*retavail = 0;
	*retfree = 0;

#define CONVERT(v)	((quad_t)(v) * pagesize / 1024)

	n = kvm_getswapinfo(kd, swapary, 1, 0);
	if (n < 0 || swapary[0].ksw_total == 0)
		return(0);

	*retavail = CONVERT(swapary[0].ksw_total);
	*retfree = CONVERT(swapary[0].ksw_total - swapary[0].ksw_used);

	n = (int)((double)swapary[0].ksw_used * 100.0 /
	    (double)swapary[0].ksw_total);
	return(n);
}
