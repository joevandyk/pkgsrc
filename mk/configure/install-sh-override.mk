# $NetBSD: install-sh-override.mk,v 1.1 2007/07/12 18:59:15 jlam Exp $

######################################################################
### install-sh-override (PRIVATE)
######################################################################
### install-sh-override replace any existing install-sh under
### ${WRKSRC} with the version from sysutils/install-sh, which works
### on all pkgsrc platforms, in particular Interix.
###
do-configure-pre-hook: install-sh-override

OVERRIDE_DIRDEPTH.install-sh?=	${OVERRIDE_DIRDEPTH}

_SCRIPT.install-sh-override=						\
	${RM} -f $$file;						\
	${SED} -e "s|@DEFAULT_INSTALL_MODE@|${PKGDIRMODE}|g"		\
		${PKGSRCDIR}/sysutils/install-sh/files/install-sh.in	\
		> $$file;						\
	${CHMOD} +x $$file

.PHONY: install-sh-override
install-sh-override:
	@${STEP_MSG} "Replacing install-sh with pkgsrc version"
.if defined(INSTALL_SH_OVERRIDE) && !empty(INSTALL_SH_OVERRIDE)
	${_PKG_SILENT}${_PKG_DEBUG}set -e;				\
	cd ${WRKSRC};							\
	set -- dummy ${INSTALL_SH_OVERRIDE}; shift;			\
	while [ $$# -gt 0 ]; do						\
		file="$$1"; shift;					\
		[ -f "$$file" ] || [ -h "$$file" ] || continue;		\
		${_SCRIPT.${.TARGET}};					\
	done
.else
	${_PKG_SILENT}${_PKG_DEBUG}set -e;				\
	cd ${WRKSRC};							\
	depth=0; pattern=install-sh;					\
	while [ $$depth -le ${OVERRIDE_DIRDEPTH.install-sh} ]; do	\
		for file in $$pattern; do				\
			[ -f "$$file" ] || [ -h "$$file" ] || continue;	\
			${_SCRIPT.${.TARGET}};				\
		done;							\
		depth=`${EXPR} $$depth + 1`; pattern="*/$$pattern";	\
	done
.endif
