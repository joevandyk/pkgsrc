# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:11:10 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
ISO_CODES_BUILDLINK3_MK:=	${ISO_CODES_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	iso-codes
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Niso-codes}
BUILDLINK_PACKAGES+=	iso-codes
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}iso-codes

.if !empty(ISO_CODES_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.iso-codes+=	iso-codes>=0.50
BUILDLINK_PKGSRCDIR.iso-codes?=	../../textproc/iso-codes
.endif	# ISO_CODES_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}