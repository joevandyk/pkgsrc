#!@SH@
#
# $NetBSD: dircproxy.sh,v 1.1.1.1 2005/04/03 14:18:02 adrianp Exp $
#

# PROVIDE: dircproxy
# REQUIRE: DAEMON

. /etc/rc.subr

name="dircproxy"
rcvar=$name
command="@PREFIX@/bin/${name}"
command_args="-f @PKG_SYSCONFDIR@/${name}rc --pid-file=/var/run/${name}.pid"
pidfile="/var/run/${name}.pid"
required_files="@PKG_SYSCONFDIR@/${name}rc"

load_rc_config $name
run_rc_command "$1"
