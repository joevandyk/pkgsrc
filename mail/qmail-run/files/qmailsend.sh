#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: qmailsend.sh,v 1.6 2005/04/15 05:17:02 schmonz Exp $
#
# @PKGNAME@ script to control qmail-send (local and outgoing mail).
#

# PROVIDE: qmailsend mail
# REQUIRE: LOGIN
# KEYWORD: shutdown

name="qmailsend"

# User-settable rc.conf variables and their default values:
: ${qmailsend_postenv:="PATH=@LOCALBASE@/bin:$PATH"}
: ${qmailsend_defaultdelivery:="`@HEAD@ -1 @PKG_SYSCONFDIR@/control/defaultdelivery`"}
: ${qmailsend_log:="YES"}
: ${qmailsend_logcmd:="logger -t nb${name} -p mail.info"}
: ${qmailsend_nologcmd:="@LOCALBASE@/bin/multilog -*"}

if [ -f /etc/rc.subr ]; then
	. /etc/rc.subr
fi

rcvar=${name}
required_files="@PKG_SYSCONFDIR@/control/defaultdelivery"
required_files="${required_files} @PKG_SYSCONFDIR@/control/me"
command="@LOCALBASE@/bin/qmail-send"
start_precmd="qmailsend_precmd"
extra_commands="stat pause cont doqueue reload queue alrm flush hup"
stat_cmd="qmailsend_stat"
pause_cmd="qmailsend_pause"
cont_cmd="qmailsend_cont"
doqueue_cmd="qmailsend_doqueue"
queue_cmd="qmailsend_queue"
alrm_cmd="qmailsend_doqueue"
flush_cmd="qmailsend_doqueue"
hup_cmd="qmailsend_hup"

qmailsend_precmd()
{
	# qmail-start(8) starts the various qmail processes, then exits.
	# qmail-send(8) is the process we want to signal later.
	if [ -f /etc/rc.subr ]; then
		checkyesno qmailsend_log || qmailsend_logcmd=${qmailsend_nologcmd}
	fi
	command="@SETENV@ - ${qmailsend_postenv} qmail-start '$qmailsend_defaultdelivery' ${qmailsend_logcmd}"
	command_args="&"
	rc_flags=""
}

qmailsend_stat()
{
	run_rc_command status
}

qmailsend_pause()
{
	if ! statusmsg=`run_rc_command status`; then
		@ECHO@ $statusmsg
		return 1
	fi
	@ECHO@ "Pausing ${name}."
	kill -STOP $rc_pid
}

qmailsend_cont()
{
	if ! statusmsg=`run_rc_command status`; then
		@ECHO@ $statusmsg
		return 1
	fi
	@ECHO@ "Continuing ${name}."
	kill -CONT $rc_pid
}

qmailsend_doqueue()
{
	if ! statusmsg=`run_rc_command status`; then
		@ECHO@ $statusmsg
		return 1
	fi
	@ECHO@ "Flushing timeout table and sending ALRM signal to qmail-send."
	@LOCALBASE@/bin/qmail-tcpok
	kill -ALRM $rc_pid
}

qmailsend_queue()
{
	@LOCALBASE@/bin/qmail-qstat
	@LOCALBASE@/bin/qmail-qread
}

qmailsend_hup()
{
	run_rc_command reload
}

if [ -f /etc/rc.subr ]; then
	load_rc_config $name
	run_rc_command "$1"
else
	@ECHO_N@ " ${name}"
	qmailsend_precmd
	eval ${command} ${qmailsend_flags} ${command_args}
fi
