#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: perdition.imap4.sh,v 1.1 2006/02/13 15:18:32 tv Exp $
#
# PROVIDE: perdition
# REQUIRE: DAEMON LOGIN

. /etc/rc.subr

procname="perdition.imap4"
name="perdition_imap4"
rcvar=$name
command="@PREFIX@/sbin/${procname}"
pidfile="/var/run/${procname}/${procname}.pid"

load_rc_config $name
run_rc_command "$1"
