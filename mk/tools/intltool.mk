# $NetBSD: intltool.mk,v 1.3 2006/07/05 10:23:58 jlam Exp $
#
# Copyright (c) 2006 The NetBSD Foundation, Inc.
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

# These tools are all supplied by the textproc/intltool package.
_TOOLS.intltool=	intltoolize					\
			intltool-extract intltool-merge			\
			intltool-prepare intltool-update

.if !defined(TOOLS_IGNORE.intltool) && !empty(USE_TOOLS:C/:.*//:Mintltool)
.  if !empty(PKGPATH:Mtextproc/intltool)
MAKEFLAGS+=		TOOLS_IGNORE.intltool
.  else
USE_TOOLS+=		perl
CONFIGURE_ENV+=		INTLTOOL_PERL=${TOOLS_PERL5:Q}
TOOLS_DEPENDS.intltool?=	intltool>=0.35:../../textproc/intltool
.    if !empty(USE_TOOLS:Mintltool\:run)
DEPENDS+=		${TOOLS_DEPENDS.intltool}
.    else
BUILD_DEPENDS+=		${TOOLS_DEPENDS.intltool}
.    endif
EVAL_PREFIX+=		TOOLS_PREFIX.intltool=intltool
.    for _t_ in ${_TOOLS.intltool}
TOOLS_DEPENDS.${_t_}=	${TOOLS_DEPENDS.intltool}
TOOLS_CREATE+=		${_t_}
TOOLS_PREFIX.${_t_}=	${TOOLS_PREFIX.intltool}
TOOLS_PATH.${_t_}=	${TOOLS_PREFIX.${_t_}}/bin/${_t_}
.    endfor
.  endif
.else
.  for _t_ in ${_TOOLS.intltool}
TOOLS_BROKEN+=		${_t_}
TOOLS_PATH.${_t_}=	${TOOLS_CMD.${_t_}}
.  endfor
.endif

# After the GNU configure script has run, replace the generated local
# versions of intltool-* with copies of the appropriate tools.  We copy
# instead of symlink so that the timestamps on the copied intltool-* are
# correctly "recent".
#
.PHONY: override-intltool override-message-intltool
.if !empty(USE_TOOLS:C/:.*//:Mintltool)
do-configure-post-hook: override-intltool
.endif
override-intltool: override-message-intltool
override-message-intltool:
	@${STEP_MSG} "Overriding intltool."

.for _t_ in ${_TOOLS.intltool}
.PHONY: override-intltool-${_t_}
override-intltool: override-intltool-${_t_}
override-intltool-${_t_}:
	${_PKG_SILENT}${_PKG_DEBUG}set -e;				\
	cd ${WRKSRC}; for f in ${_t_} */${_t_} */*/${_t_}; do		\
		if ${TEST} -f "$$f"; then				\
			${RM} -f $$f;					\
			${CP} -f ${TOOLS_PATH.${_t_}:Q} $$f;		\
			${CHMOD} +x $$f;				\
		fi;							\
	done
.endfor
