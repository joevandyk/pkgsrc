# $NetBSD: options.mk,v 1.3 2007/08/07 04:59:33 lukem Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.tnftp
PKG_SUPPORTED_OPTIONS=		inet6
PKG_OPTIONS_OPTIONAL_GROUPS+=	socks
PKG_OPTIONS_GROUP.socks=	socks5

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Msocks5)
CONFIGURE_ARGS+=	--with-socks
.include "../../net/socks5/buildlink3.mk"
.endif

.if !empty(PKG_OPTIONS:Minet6)
CONFIGURE_ARGS+=	--enable-ipv6
.else
CONFIGURE_ARGS+=	--disable-ipv6
.endif
