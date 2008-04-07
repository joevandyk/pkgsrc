# $NetBSD: options.mk,v 1.8 2007/10/31 21:42:24 gdt Exp $

PKG_OPTIONS_VAR		= PKG_OPTIONS.gecko
PKG_SUPPORTED_OPTIONS	= debug

.if ( ${MOZILLA_BIN} == "firefox-bin" || ${MOZILLA_BIN} == "thunderbird-bin" )
PKG_SUPPORTED_OPTIONS  += official-mozilla-branding
.endif

.if ( ${MOZILLA_BIN} == "firefox-bin" || ${MOZILLA_BIN} == "seamonkey-bin" || ${MOZILLA_BIN} == "thunderbird-bin" )
PKG_SUPPORTED_OPTIONS  += mozilla-single-profile
.endif

.include "../../mk/bsd.options.mk"

# this .if test looks backward, but the missing options disables debug,
# so it is correct
.if empty(PKG_OPTIONS:Mdebug)
CONFIGURE_ARGS+=	--disable-debug
.else
CONFIGURE_ARGS+=	--enable-debug
.endif

.if !empty(PKG_OPTIONS:Mmozilla-single-profile)
CONFIGURE_ARGS+=	--enable-single-profile
.endif

# Enable Official mozilla.org Branding for Firefox or Thunderbird.
# Note that you cannot distribute builds with Official Branding
# without permission of the Mozilla Foundation.
# See http://www.mozilla.org/foundation/trademarks/
.if !empty(PKG_OPTIONS:Mofficial-mozilla-branding)
CONFIGURE_ARGS+=	--enable-official-branding
# Mozilla prohibits distribution of packages with their trademarks.
# It is an open question if this makes the package non-Free.  Mozilla
# claims not, but currently pkgsrc has a "open source implies no
# redistribution restrictions" notion.
LICENSE=		mozilla-trademark-license
RESTRICTED=		Trademark holder prohibits distribution of modified versions.
NO_BIN_ON_CDROM=	${RESTRICTED}
NO_BIN_ON_FTP=		${RESTRICTED}
.endif
