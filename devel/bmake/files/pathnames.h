/*	$NetBSD: pathnames.h,v 1.2 2007/09/06 19:23:26 joerg Exp $	*/

/*
 * Copyright (c) 1990, 1993
 *	The Regents of the University of California.  All rights reserved.
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
 *
 *	from: @(#)pathnames.h	5.2 (Berkeley) 6/1/90
 *	$Id: pathnames.h,v 1.2 2007/09/06 19:23:26 joerg Exp $
 */

#if HAVE_CONFIG_H
#include "config.h"
#endif
#ifndef MAKE_NATIVE
#if HAVE_NBTOOL_CONFIG_H
#include "nbtool_config.h"
#endif
#endif
#ifdef HAVE_PATHS_H
#include <paths.h>
#endif

#ifndef	DEFAULT_CSH
#define	DEFAULT_CSH		"/bin/csh"
#endif
#ifndef	DEFAULT_KSH
#define	DEFAULT_KSH		"/bin/ksh"
#endif
#ifndef	DEFAULT_SH
#define	DEFAULT_SH		"/bin/sh"
#endif

#define	_PATH_OBJDIR		"obj"
#define	_PATH_OBJDIRPREFIX	"/usr/obj"
#define	_PATH_DEFSYSMK		"sys.mk"
#define _path_defsyspath	"/usr/share/mk:/usr/local/share/mk:/opt/share/mk"
