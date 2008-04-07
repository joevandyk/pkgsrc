# $NetBSD: buildlink3.mk,v 1.10 2007/09/07 17:16:43 reed Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBMM_BUILDLINK3_MK:=	${LIBMM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libmm
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibmm}
BUILDLINK_PACKAGES+=	libmm
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libmm

.if !empty(LIBMM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libmm+=	libmm>=1.4.0
BUILDLINK_PKGSRCDIR.libmm?=	../../devel/libmm
.endif	# LIBMM_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}