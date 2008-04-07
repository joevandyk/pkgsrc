# $NetBSD: options.mk,v 1.5 2007/08/05 18:41:52 tron Exp $

.include "../../mk/bsd.prefs.mk"

PKG_OPTIONS_VAR=	PKG_OPTIONS.imap-uw
PKG_SUPPORTED_OPTIONS+=	imapuw-cleartextpwd imapuw-whoson inet6 ssl
PKG_SUGGESTED_OPTIONS+=	imapuw-cleartextpwd ssl

# On NetBSD 1.x, using the native Kerberos 5 implementation causes
# interoperability problems with OpenSSL 0.9.7 and above.
#
.if !empty(MACHINE_PLATFORM:MNetBSD-1.*)
CHECK_BUILTIN.heimdal:=	yes
.  include "../../security/heimdal/builtin.mk"
CHECK_BUILTIN.heimdal:=	no
.  if !empty(USE_BUILTIN.heimdal:M[nN][oO])
PKG_SUPPORTED_OPTIONS+=	kerberos
.  endif
.else
PKG_SUPPORTED_OPTIONS+=	kerberos
.endif

.include "../../mk/bsd.options.mk"

###
### Support both IPv6 and IPv4 connections.
###
.if !empty(PKG_OPTIONS:Minet6)
MAKE_FLAGS+=	IP=6
.else
MAKE_FLAGS+=	IP=4
.endif

###
### Support GSSAPI authentication via Kerberos 5.
###
.if !empty(PKG_OPTIONS:Mkerberos)
.  include "../../mk/krb5.buildlink3.mk"
MAKE_ENV+=	KRB5_TYPE=${KRB5_TYPE}
MAKE_FLAGS+=	EXTRAAUTHENTICATORS=gss
EXTRASPECIALS+=	GSSDIR=${KRB5BASE}
CFLAGS.heimdal=	-DHEIMDAL_KRB5
CFLAGS+=	${CFLAGS.${KRB5_TYPE}}
.endif

###
### Support using WHOSON for authentication.
###
.if !empty(PKG_OPTIONS:Mimapuw-whoson)
.  include "../../net/whoson/buildlink3.mk"
LDFLAGS+=	-lwhoson
CFLAGS+=	-DUSE_WHOSON
.endif

###
### Support SSL/TLS connections.
###
.if !empty(PKG_OPTIONS:Mssl)
.  include "../../security/openssl/buildlink3.mk"
.  if !empty(PKG_OPTIONS:Mimapuw-cleartextpwd)
MAKE_FLAGS+=	SSLTYPE=unix	# plaintext auth
.  else
MAKE_FLAGS+=	SSLTYPE=nopwd	# plaintext auth only over SSL/TLS
.  endif
MESSAGE_SRC+=	${PKGDIR}/MESSAGE.ssl
MESSAGE_SUBST+=	SSLCERTS=${SSLCERTS:Q}
MESSAGE_SUBST+=	SSLKEYS=${SSLKEYS:Q}

EXTRASPECIALS+=	SSLDIR=${SSLBASE:Q}
EXTRASPECIALS+=	SSLCERTS=${SSLCERTS:Q}
EXTRASPECIALS+=	SSLKEYS=${SSLKEYS:Q}
.else
MAKE_FLAGS+=	SSLTYPE=none	# no SSL/TLS
.endif
