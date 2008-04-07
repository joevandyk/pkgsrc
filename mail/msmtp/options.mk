# $NetBSD: options.mk,v 1.9 2007/09/08 08:05:23 obache Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.msmtp

PKG_OPTIONS_OPTIONAL_GROUPS=	ssl
PKG_OPTIONS_GROUP.ssl=	gnutls ssl

PKG_SUPPORTED_OPTIONS=	gsasl idn inet6
PKG_SUGGESTED_OPTIONS=	ssl

.include "../../mk/bsd.options.mk"

###
### SSL support
###
.if !empty(PKG_OPTIONS:Mssl)
.  include "../../security/openssl/buildlink3.mk"
CONFIGURE_ARGS+=	--with-ssl=openssl
.elif !empty(PKG_OPTIONS:Mgnutls)
.  include "../../security/gnutls/buildlink3.mk"
CONFIGURE_ARGS+=	--with-ssl=gnutls
.else
CONFIGURE_ARGS+=	--disable-ssl
.endif

###
### GNUsasl support
###
.if !empty(PKG_OPTIONS:Mgsasl)
.  include "../../security/gsasl/buildlink3.mk"
.endif

###
### Internationalized Domain Names (IDN) support
###
.if !empty(PKG_OPTIONS:Midn)
.  include "../../devel/libidn/buildlink3.mk"
CONFIGURE_ARGS+=	--with-libidn
.endif
