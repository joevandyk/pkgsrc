# $NetBSD: options.mk,v 1.2 2007/11/07 15:24:27 shannonjr Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.gnupg2
PKG_SUPPORTED_OPTIONS=	gpgsm idea

.include "../../mk/bsd.prefs.mk"
.include "../../mk/bsd.options.mk"

## If no options are specified, only gpg-agent is built. This
## is sufficient for OpenPGP/MIME support in Kmail
## SMIME support is provided by gpgsm. This support is
## in the alpha stage of development.
PLIST_SRC=      ${.CURDIR}/PLIST

# XXX It looks like that gpgsm support could be split into its own package,
# according to the configure script.  If that's true, this use of the options
# framework is incorrect and should be fixed.
.if empty(PKG_OPTIONS:Mgpgsm)
CONFIGURE_ARGS+=        --enable-agent-only
.else
CONFIGURE_ARGS+=	--enable-gpgsm
CONFIGURE_ARGS+=	--with-dirmngr-pgm=${BUILDLINK_PREFIX.dirmngr}/bin/dirmngr
PLIST_SRC+=     ${.CURDIR}/PLIST.gpgsm
.  include "../../security/dirmngr/buildlink3.mk"
.endif

.if !empty(PKG_OPTIONS:Midea)
LICENSE=        idea-license
RESTRICTED=     Commercial distribution is claimed to require a license.
NO_SRC_ON_CDROM=        ${RESTRICTED}
NO_BIN_ON_CDROM=        ${RESTRICTED}

PATCH_SITES=		http://www.kfwebs.com/
PATCHFILES+=		gnupg-2.0.4-idea.patch
PATCH_DIST_STRIP=	-p1

PKGSRC_MAKE_ENV+=	PKG_OPTIONS.libgcrypt+=idea
.endif
