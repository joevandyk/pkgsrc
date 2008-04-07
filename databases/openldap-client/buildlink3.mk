# $NetBSD: buildlink3.mk,v 1.5 2007/05/30 08:54:28 rillig Exp $

BUILDLINK_DEPTH:=			${BUILDLINK_DEPTH}+
OPENLDAP_BUILDLINK3_MK:=		${OPENLDAP_BUILDLINK3_MK}+

.include "../../mk/bsd.fast.prefs.mk"

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=			openldap-client
.endif

BUILDLINK_PACKAGES:=			${BUILDLINK_PACKAGES:Nopenldap-client}
BUILDLINK_PACKAGES+=			openldap-client
BUILDLINK_ORDER:=			${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}openldap-client

.if !empty(OPENLDAP_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.openldap-client+=	openldap-client>=2.3.11nb2
BUILDLINK_PKGSRCDIR.openldap-client?=	../../databases/openldap-client

# Export the deprecated API from the openldap-2.2.x releases.
BUILDLINK_CPPFLAGS.openldap-client+=	-DLDAP_DEPRECATED
.endif	# OPENLDAP_BUILDLINK3_MK

pkgbase := openldap-client
.include "../../mk/pkg-build-options.mk"

.if !empty(PKG_BUILD_OPTIONS.openldap-client:Mkerberos) || \
    !empty(PKG_BUILD_OPTIONS.openldap-client:Msasl)
.  include "../../security/cyrus-sasl/buildlink3.mk"
.endif
.include "../../security/openssl/buildlink3.mk"

BUILDLINK_DEPTH:=			${BUILDLINK_DEPTH:S/+$//}
