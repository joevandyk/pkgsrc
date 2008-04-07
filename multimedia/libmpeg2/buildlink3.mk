# $NetBSD: buildlink3.mk,v 1.10 2007/02/22 17:43:51 drochner Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBMPEG2_BUILDLINK3_MK:=	${LIBMPEG2_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libmpeg2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibmpeg2}
BUILDLINK_PACKAGES+=	libmpeg2
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libmpeg2

.if !empty(LIBMPEG2_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libmpeg2+=	libmpeg2>=0.4.0
BUILDLINK_ABI_DEPENDS.libmpeg2+=	libmpeg2>=0.4.0bnb5
BUILDLINK_PKGSRCDIR.libmpeg2?=	../../multimedia/libmpeg2
.endif	# LIBMPEG2_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}