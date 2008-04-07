# $NetBSD: options.mk,v 1.1 2005/06/02 21:39:53 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.jabberd
PKG_SUPPORTED_OPTIONS=	inet6

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Minet6)
CONFIGURE_ARGS+=	--enable-ipv6
.endif
