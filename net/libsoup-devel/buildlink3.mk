# $NetBSD: buildlink3.mk,v 1.11 2007/07/09 17:17:54 drochner Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBSOUP_DEVEL_BUILDLINK3_MK:=	${LIBSOUP_DEVEL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libsoup-devel
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibsoup-devel}
BUILDLINK_PACKAGES+=	libsoup-devel
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libsoup-devel

.if !empty(LIBSOUP_DEVEL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libsoup-devel+=	libsoup-devel>=2.2.0
BUILDLINK_ABI_DEPENDS.libsoup-devel?=	libsoup-devel>=2.2.100nb1
BUILDLINK_PKGSRCDIR.libsoup-devel?=	../../net/libsoup-devel
.endif	# LIBSOUP_DEVEL_BUILDLINK3_MK

.include "../../devel/glib2/buildlink3.mk"
.include "../../security/gnutls/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
