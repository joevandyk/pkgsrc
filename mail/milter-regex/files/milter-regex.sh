#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: milter-regex.sh,v 1.1 2006/03/08 22:01:21 tron Exp $
#

# PROVIDE: milter-regex
# REQUIRE: DAEMON
# BEFORE:  mail

name="milterregex"
rcvar="milterregex"
command="@PREFIX@/sbin/milter-regex"
command_args="-u smmsp"

if [ -f /etc/rc.subr -a -d /etc/rc.d -a -f /etc/rc.d/DAEMON ]; then
	. /etc/rc.subr
	. /etc/rc.conf

	load_rc_config $name
	run_rc_command "$1"

else				# old NetBSD, Solaris, Linux, etc...
	pidfile=/var/run/${name}.pid

	case $1 in
	start)
		nohup ${command} -D ${command_args} </dev/null >/dev/null 1>&2 &
		echo $! >${pidfile}
		
		;;
	stop)
		if [ -f ${pidfile} ]
		then
			kill `cat ${pidfile}`
			rm -f ${pidfile}
		fi
		;;
	*)
		@ECHO@ "Usage: $0 {start|stop}" 1>&2
		exit 64
		;;
	esac

fi
