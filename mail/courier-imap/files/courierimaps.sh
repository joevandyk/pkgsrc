#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: courierimaps.sh,v 1.17 2007/09/22 04:42:03 jlam Exp $
#
# Courier IMAP/SSL services daemon
#
# PROVIDE: courierimaps
# REQUIRE: authdaemond
# KEYWORD: shutdown

. /etc/rc.subr

name="courierimaps"
rcvar=${name}
command="@PREFIX@/sbin/couriertcpd"
ctl_command="@PREFIX@/sbin/imapd-ssl"
pidfile="@COURIER_STATEDIR@/tmp/imapd-ssl.pid"
required_files="@PKG_SYSCONFDIR@/imapd @PKG_SYSCONFDIR@/imapd-ssl"

start_cmd="${name}_doit start"
stop_cmd="${name}_doit stop"

courierimaps_doit()
{
	action=$1
	case $action in
	start)
		for f in $required_files; do
			if [ ! -r "$f" ]; then
				@ECHO@ 1>&2 "$0: WARNING: $f is not readable"
				return 1
			fi
		done

		. @PKG_SYSCONFDIR@/imapd
		. @PKG_SYSCONFDIR@/imapd-ssl

		f="$TLS_CERTFILE"
		if [ -z "$f" ]; then
			@ECHO@ 1>&2 "$0: WARNING: TLS_CERTFILE is empty"
			return 1
		fi
		if [ ! -f "$f" ] && \
		   [ "$f" = "@PKG_SYSCONFDIR@/imapd.pem" ]; then
			@ECHO@ "Generating IMAP SSL certificate in $f."
			@PREFIX@/sbin/mkimapdcert >/dev/null 2>&1
		fi
		if [ ! -r "$f" ]; then
			@ECHO@ 1>&2 "$0: WARNING: $f is not readable"
			return 1
		fi

		case x$IMAPDSSLSTART in
		x[yY]*)
			@ECHO@ "Starting ${name}."
			${ctl_command} $action
               	;;
		esac
		;;
	stop)
		@ECHO@ "Stopping ${name}."
		${ctl_command} $action
		;;
	esac
}

load_rc_config $name
run_rc_command "$1"
