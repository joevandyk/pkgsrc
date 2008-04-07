#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: dovecot.sh,v 1.2 2007/05/16 07:34:47 ghen Exp $
#

# PROVIDE: dovecot
# REQUIRE: DAEMON LOGIN

. /etc/rc.subr

name="dovecot"
rcvar=$name
command="@PREFIX@/sbin/${name}"
required_files="@PKG_SYSCONFDIR@/$name.conf"
extra_commands="reload"

load_rc_config $name
run_rc_command "$1"
