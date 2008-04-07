# $NetBSD: options.mk,v 1.1 2007/03/23 18:59:41 abs Exp $
#

PKG_OPTIONS_VAR=	PKG_OPTIONS.ns-flash
PKG_SUPPORTED_OPTIONS=	nspluginwrapper

# XXXX: If nspluginwrapper is enabled and this package is installed after
# firefox (or similar) it will install a system wide wrapped plugin into
# @PREFIX/lib/<browser>/plugins. If it is installed before a browser
# it will install a plugin for the current user in ~/.mozilla/plugins/
# or similar. This is inconsistant and potentially confusing.

.if ${MACHINE_ARCH} == "i386" && ${OPSYS} != "Linux"
PKG_SUGGESTED_OPTIONS=  nspluginwrapper
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mnspluginwrapper)
DEPENDS+= nspluginwrapper>0:../../www/nspluginwrapper
DEPENDS+= libflashsupport>0:../../multimedia/libflashsupport
INSTALL_TEMPLATES+=	${PKGDIR}/INSTALL.nspluginwrapper
DEINSTALL_TEMPLATES+=	${PKGDIR}/INSTALL.nspluginwrapper
.endif
