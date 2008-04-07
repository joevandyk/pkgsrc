# $NetBSD: options.mk,v 1.10 2006/05/31 18:22:25 ghen Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.cyrus-saslauthd
PKG_SUPPORTED_OPTIONS=	pam kerberos ldap gssapi

.include "../../mk/bsd.options.mk"

###
### PAM (Pluggable Authentication Mechanism)
###
.if !empty(PKG_OPTIONS:Mpam)
.  include "../../mk/pam.buildlink3.mk"
CONFIGURE_ARGS+=	--with-pam=${PAMBASE:Q}
.else
CONFIGURE_ARGS+=	--without-pam
.endif

###
### Authentication against information stored in an LDAP directory
###
.if !empty(PKG_OPTIONS:Mldap)
.  include "../../databases/openldap-client/buildlink3.mk"
.  include "../../security/cyrus-sasl/buildlink3.mk"
BUILDLINK_INCDIRS.cyrus-sasl=	include/sasl
CONFIGURE_ARGS+=	--with-ldap=${BUILDLINK_PREFIX.openldap-client}
PLIST_SUBST+=		LDAP=
.else
CONFIGURE_ARGS+=	--without-ldap
PLIST_SUBST+=		LDAP="@comment "
.endif

###
### Kerberos authentication is via GSSAPI.
###
.if !empty(PKG_OPTIONS:Mkerberos)
.  if empty(PKG_OPTIONS:Mgssapi)
PKG_OPTIONS+=		gssapi
.  endif
.endif

###
### Authentication via GSSAPI (which supports primarily Kerberos 5)
###
.if !empty(PKG_OPTIONS:Mgssapi)
.  include "../../mk/krb5.buildlink3.mk"
CONFIGURE_ARGS+=	--enable-gssapi=${KRB5BASE:Q}
CONFIGURE_ARGS+=	--with-gss_impl=${GSSIMPL.${KRB5_TYPE}}
GSSIMPL.heimdal=	heimdal
GSSIMPL.mit-krb5=	mit
.endif
