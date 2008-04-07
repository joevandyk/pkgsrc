# $NetBSD: find-libs.mk,v 1.3 2005/07/15 18:27:55 jlam Exp $
#
# Copyright (c) 2005 The NetBSD Foundation, Inc.
# All rights reserved.
#
# This code is derived from software contributed to The NetBSD Foundation
# by Johnny C. Lam.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#        This product includes software developed by the NetBSD
#        Foundation, Inc. and its contributors.
# 4. Neither the name of The NetBSD Foundation nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

#
# This is a "subroutine" that can be included to detect the presence of
# libraries in the base system.
#
# The input variable is BUILDLINK_FIND_LIBS, which is a list of library
# names, e.g. ncurses, iconv, etc., that will be sought in the base
# system.  BUILTIN_LIB_FOUND.<lib> is set to "yes" or "no" depending
# on the result of the search.
#
# An example use is:
#
# BUILDLINK_FIND_LIBS:=	intl iconv
# .include "../../mk/buildlink3/find-libs.mk"
# # ${BUILTIN_LIB_FOUND.intl} and ${BUILTIN_LIB_FOUND.iconv} are now
# # either "yes" or "no".
#

.if empty(USE_TOOLS:Mecho)
USE_TOOLS+=	echo
.endif
.if empty(USE_TOOLS:Mtest)
USE_TOOLS+=	test
.endif

.for _lib_ in ${BUILTIN_FIND_LIBS}
.  if !defined(BUILTIN_LIB_FOUND.${_lib_})
BUILTIN_LIB_FOUND.${_lib_}!=	\
	if ${TEST} "`${ECHO} /usr/lib${ABI}/lib${_lib_}.*`" != "/usr/lib${ABI}/lib${_lib_}.*"; then \
		${ECHO} yes;						\
	elif ${TEST} "`${ECHO} /lib${ABI}/lib${_lib_}.*`" != "/lib${ABI}/lib${_lib_}.*"; then \
		${ECHO} yes;						\
	else								\
		${ECHO} no;						\
	fi
.  endif
MAKEVARS+=	BUILTIN_LIB_FOUND.${_lib_}
.endfor
