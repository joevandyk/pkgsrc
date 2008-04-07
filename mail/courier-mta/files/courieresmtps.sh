#!@RCD_SCRIPTS_SHELL@
#
# $NetBSD: courieresmtps.sh,v 1.5 2007/09/22 04:42:03 jlam Exp $
#
# Courier ESMTP/SSL services daemon
#
# PROVIDE: courieresmtps
# REQUIRE: authdaemond courierd
# KEYWORD: shutdown

. /etc/rc.subr

name="courieresmtps"
rcvar=${name}
command="@PREFIX@/sbin/couriertcpd"
ctl_command="@PREFIX@/sbin/esmtpd-ssl"
pidfile="@COURIER_STATEDIR@/tmp/esmtpd-ssl.pid"
required_files="@PKG_SYSCONFDIR@/esmtpd @PKG_SYSCONFDIR@/esmtpd-ssl"

start_cmd="${name}_doit start"
stop_cmd="${name}_doit stop"

courieresmtps_doit()
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

		. @PKG_SYSCONFDIR@/esmtpd
		. @PKG_SYSCONFDIR@/esmtpd-ssl

		f="$TLS_CERTFILE"
		if [ -z "$f" ]; then
			@ECHO@ 1>&2 "$0: WARNING: TLS_CERTFILE is empty"
			return 1
		fi
		if [ ! -f "$f" ] &&
		   [ "$f" = "@PKG_SYSCONFDIR@/esmtpd.pem" ]; then
			@ECHO@ "Generating ESMTP SSL certificate in $f."
			@PREFIX@/sbin/mkesmtpdcert >/dev/null 2>&1
		fi
		if [ ! -r "$f" ]; then
			@ECHO@ 1>&2 "$0: WARNING: $f is not readable"
			return 1
		fi

		case x$ESMTPDSSLSTART in
		x[yY]*)
			@ECHO@ "Starting ${name}."
			@TEST@ -f @PKG_SYSCONFDIR@/esmtpacceptmailfor.dat ||
				@PREFIX@/sbin/makeacceptmailfor
			@TEST@ -f @PKG_SYSCONFDIR@/${ACCESSFILE}.dat ||
				@PREFIX@/sbin/makesmtpaccess
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
