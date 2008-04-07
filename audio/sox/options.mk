# $NetBSD: options.mk,v 1.1 2007/08/06 05:28:37 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.sox
PKG_SUPPORTED_OPTIONS=	lame oss
# lame has LICENSE= issues and thus should not be SUGGESTED.
PKG_SUGGESTED_OPTIONS=
.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mlame)
# This is an option due to LICENSE= issues.
.include "../../audio/lame/buildlink3.mk"
.endif

.if empty(PKG_OPTIONS:Moss)
CONFIGURE_ARGS+=	--without-oss
.endif
