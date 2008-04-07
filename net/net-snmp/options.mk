# $NetBSD: options.mk,v 1.6 2007/11/20 07:51:35 dsainty Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.net-snmp
PKG_SUPPORTED_OPTIONS=		ssl

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} != "SunOS" && ${OPSYS} != "Darwin"
# net-snmp doesn't do IPv6 on Solaris & Darwin
PKG_SUPPORTED_OPTIONS+=	inet6
.endif

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Minet6)
CONFIGURE_ARGS+=	--enable-ipv6
PLIST_SUBST+=		IPV6H=
.else
CONFIGURE_ARGS+=	--disable-ipv6
PLIST_SUBST+=		IPV6H="@comment "
.endif

.if !empty(PKG_OPTIONS:Mssl)
.  include "../../security/openssl/buildlink3.mk"
CONFIGURE_ARGS+=	--with-openssl
.else
CONFIGURE_ARGS+=	--without-openssl
.endif
