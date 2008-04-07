/*	$NetBSD: tty_subs.c,v 1.6 2007/03/08 17:18:19 rillig Exp $	*/

/*-
 * Copyright (c) 1992 Keith Muller.
 * Copyright (c) 1992, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Keith Muller of the University of California, San Diego.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#if HAVE_CONFIG_H
#include "config.h"
#endif
#if HAVE_NBTOOL_CONFIG_H
#include "nbtool_config.h"
#endif

#include <nbcompat.h>
#if HAVE_SYS_CDEFS_H
#include <sys/cdefs.h>
#endif
#if !defined(lint)
#if 0
static char sccsid[] = "@(#)tty_subs.c	8.2 (Berkeley) 4/18/94";
#else
__RCSID("$NetBSD: tty_subs.c,v 1.6 2007/03/08 17:18:19 rillig Exp $");
#endif
#endif /* not lint */

#if HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif
#if HAVE_SYS_TIME_H
#include <sys/time.h>
#endif
#if HAVE_SYS_STAT_H
#include <sys/stat.h>
#endif
#if HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#if HAVE_FCNTL_H
#include <fcntl.h>
#endif
#if HAVE_STDIO_H
#include <stdio.h>
#endif
#if HAVE_CTYPE_H
#include <ctype.h>
#endif
#if HAVE_ERRNO_H
#include <errno.h>
#endif
#if HAVE_UNISTD_H
#include <unistd.h>
#endif
#if HAVE_STDLIB_H
#include <stdlib.h>
#endif
#if HAVE_STRING_H
#include <string.h>
#endif
#include "pax.h"
#include "extern.h"
#if HAVE_STDARG_H
#include <stdarg.h>
#endif

/*
 * routines that deal with I/O to and from the user
 */

#define DEVTTY		"/dev/tty"	/* device for interactive i/o */
static FILE *ttyoutf = NULL;		/* output pointing at control tty */
static FILE *ttyinf = NULL;		/* input pointing at control tty */

/*
 * tty_init()
 *	Try to open the controlling terminal (if any) for this process. If the
 *	open fails, future ops that require user input will get an EOF.
 */

int
tty_init(void)
{
	int ttyfd;

	if ((ttyfd = open(DEVTTY, O_RDWR)) >= 0) {
		if ((ttyoutf = fdopen(ttyfd, "w")) != NULL) {
			if ((ttyinf = fdopen(ttyfd, "r")) != NULL)
				return 0;
			(void)fclose(ttyoutf);
		}
		(void)close(ttyfd);
	}

	if (iflag) {
		tty_warn(1, "Fatal error, cannot open %s", DEVTTY);
		return -1;
	}
	return 0;
}

/*
 * tty_prnt()
 *	print a message using the specified format to the controlling tty
 *	if there is no controlling terminal, just return.
 */

void
tty_prnt(const char *fmt, ...)
{
	va_list ap;
	if (ttyoutf == NULL)
		return;
	va_start(ap, fmt);
	(void)vfprintf(ttyoutf, fmt, ap);
	va_end(ap);
	(void)fflush(ttyoutf);
}

/*
 * tty_read()
 *	read a string from the controlling terminal if it is open into the
 *	supplied buffer
 * Return:
 *	0 if data was read, -1 otherwise.
 */

int
tty_read(char *str, int len)
{
	char *pt;

	if ((--len <= 0) || (ttyinf == NULL) || (fgets(str,len,ttyinf) == NULL))
		return -1;
	*(str + len) = '\0';

	/*
	 * strip off that trailing newline
	 */
	if ((pt = strchr(str, '\n')) != NULL)
		*pt = '\0';
	return 0;
}

/*
 * tty_warn()
 *	write a warning message to stderr. if "set" the exit value of pax
 *	will be non-zero.
 */

void
tty_warn(int set, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	if (set)
		exit_val = 1;
	/*
	 * when vflag we better ship out an extra \n to get this message on a
	 * line by itself
	 */
	if (vflag && vfpart) {
		(void)fputc('\n', stderr);
		vfpart = 0;
	}
	(void)fprintf(stderr, "%s: ", argv0);
	(void)vfprintf(stderr, fmt, ap);
	va_end(ap);
	(void)fputc('\n', stderr);
}

/*
 * syswarn()
 *	write a warning message to stderr. if "set" the exit value of pax
 *	will be non-zero.
 */

void
syswarn(int set, int errnum, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);
	if (set)
		exit_val = 1;
	/*
	 * when vflag we better ship out an extra \n to get this message on a
	 * line by itself
	 */
	if (vflag && vfpart) {
		(void)fputc('\n', stdout);
		vfpart = 0;
	}
	(void)fprintf(stderr, "%s: ", argv0);
	(void)vfprintf(stderr, fmt, ap);
	va_end(ap);

	/*
	 * format and print the errno
	 */
	if (errnum > 0)
		(void)fprintf(stderr, " (%s)", strerror(errnum));
	(void)fputc('\n', stderr);
}
