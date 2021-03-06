# $NetBSD: buildlink3.mk,v 1.5 2006/07/08 23:10:59 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
DJBFFT_BUILDLINK3_MK:=	${DJBFFT_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	djbfft
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndjbfft}
BUILDLINK_PACKAGES+=	djbfft
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}djbfft

.if !empty(DJBFFT_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.djbfft+=	djbfft>=0.76
BUILDLINK_PKGSRCDIR.djbfft?=	../../math/djbfft
BUILDLINK_DEPMETHOD.djbfft?=	build
.endif	# DJBFFT_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
