# $NetBSD: check-portability.mk,v 1.4 2007/03/16 10:29:22 rillig Exp $
#
# This file contains some checks that are applied to the configure
# scripts to check for certain constructs that are known to cause
# problems on some platforms.
#
# The following variables may be set by the pkgsrc user in mk.conf:
#
# CHECK_PORTABILITY: YesNo
#	Whether to enable some portability checks for the configure
#	scripts before they are run.
#
#	Default value: yes for PKG_DEVELOPERs, no otherwise.
#
# The following variables may be set by the package:
#
# SKIP_PORTABILITY_CHECK: YesNo
#	Whether the above checks should be skipped for the current
#	package.
#
#	Default value: no
#	Deprecated: Use CHECK_PORTABILITY_SKIP instead.
#
# CHECK_PORTABILITY_SKIP: List of Pathmask
#	The list of files that should be skipped in the portability
#	check.
#
#	Default value: empty.
#

_VARGROUPS+=			check-portability
_USER_VARS.check-portability=	CHECK_PORTABILITY
_PKG_VARS.check-portability=	SKIP_PORTABILITY_CHECK CHECK_PORTABILITY_SKIP

.if defined(PKG_DEVELOPER)
CHECK_PORTABILITY?=		yes
.endif
CHECK_PORTABILITY?=		no
SKIP_PORTABILITY_CHECK?=	no
CHECK_PORTABILITY_SKIP?=	# none

.if ${CHECK_PORTABILITY:M[Yy][Ee][Ss]} != "" && \
    ${SKIP_PORTABILITY_CHECK:M[Yy][Ee][Ss]} == ""
pre-configure-checks-hook: _check-portability
.endif
.PHONY: _check-portability
_check-portability:
	@${STEP_MSG} "Checking for portability problems in extracted files"
	${RUN}								\
	[ -d ${WRKSRC}/. ] || exit 0;					\
	cd ${WRKSRC};							\
	env	SKIP_FILTER=${CHECK_PORTABILITY_SKIP:@p@${p}) skip=yes;;@:Q} \
		sh ${PKGSRCDIR}/mk/check/check-portability.sh
