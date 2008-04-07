/* $NetBSD: unshlight.c,v 1.1.1.1 2001/03/09 16:09:36 wiz Exp $ */
#include <sys/param.h>
#include <sys/mount.h>

#include <err.h>
#include <sysexits.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>

static void usage(void);

int
main(int argc, char** argv)
{
	struct statfs* mntbuf;
	int mntcount, i;
	int aflag=0;
	int ch;
	
	while ( (ch = getopt(argc, argv, "a")) != -1) {
		switch (ch) {
		case 'a':
			aflag=1;
			break;
		case '?':
		default:
			usage();
		}
	}
	argc -= optind;
	argv += optind;
	if (aflag && argc != 0)
		usage();
	if (!aflag && argc == 0)
		usage();

	for (; argc>0 || aflag; aflag?(void)(aflag=0):(void)(argc--, argv++)) {
		char abspath[MAXPATHLEN];
		pid_t pid=0;
		if (argc > 0) {
			if (realpath(argv[0], abspath) == 0) {
				warn(abspath);
				continue;
			}
		}
		mntcount=getmntinfo(&mntbuf, MNT_NOWAIT);
		if (mntcount < 0)
			err(EX_OSERR, "getmntinfo");
		for (i=0; i<mntcount; i++) {
			char* s;
			int error;
			if (argc > 0 && strcmp(abspath, mntbuf[i].f_mntonname) != 0) continue;
			if (strcmp(mntbuf[i].f_fstypename,MOUNT_NFS) !=0 ) continue;
			if (strncmp(mntbuf[i].f_mntfromname, "shlight-", 8) != 0) continue;
			pid=strtoul(mntbuf[i].f_mntfromname+8, &s, 10);
			if (*s) continue;
			error = unmount (mntbuf[i].f_mntonname, 0);
			if (error == 0) {
				kill (pid, SIGHUP);
			} else {
				warn(mntbuf[i].f_mntonname);
			}
		}
		if (argc > 0 && !pid) 
			warnx("%s: not currently mounted", abspath);
	}
}

void
usage(void)
{
	errx(EX_USAGE, "Usage: unshlight [-a] [node]");
}
