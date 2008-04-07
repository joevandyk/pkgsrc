# $NetBSD: buildlink3.mk,v 1.7 2006/07/08 23:11:12 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBGHTTP_BUILDLINK3_MK:=	${LIBGHTTP_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libghttp
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibghttp}
BUILDLINK_PACKAGES+=	libghttp
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libghttp

.if !empty(LIBGHTTP_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libghttp+=	libghttp>=1.0.9
BUILDLINK_ABI_DEPENDS.libghttp+=	libghttp>=1.0.9nb1
BUILDLINK_PKGSRCDIR.libghttp?=	../../www/libghttp
.endif	# LIBGHTTP_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}