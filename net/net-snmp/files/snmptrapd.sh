#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: snmptrapd.sh,v 1.4 2006/05/12 19:52:33 adam Exp $
#
# PROVIDE: snmptrapd
# REQUIRE: DAEMON

if [ -f /etc/rc.subr ]; then
	. /etc/rc.subr
fi

name="snmptrapd"
rcvar=$name
command="@PREFIX@/sbin/${name}"
pidfile="/var/run/${name}.pid"
snmptrapd_flags="-Ls 1"	# log using syslog w/ facility LOG_LOCAL1
command_args="-p ${pidfile}"

if [ -f @PKG_SYSCONFDIR@/snmptrapd.conf ]; then
	command_args="${command_args} -c @PKG_SYSCONFDIR@/snmptrapd.conf"
fi

if [ -f /etc/rc.subr -a -f /etc/rc.conf -a -f /etc/rc.d/DAEMON ]; then
        load_rc_config $name
        run_rc_command "$1"
else
	@ECHO@ -n " ${name}"
	${command} ${snmptrapd_flags} ${command_args}
fi
