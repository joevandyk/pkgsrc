# $NetBSD: buildlink3.mk,v 1.10 2006/07/08 23:10:51 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GLE_BUILDLINK3_MK:=	${GLE_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gle
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngle}
BUILDLINK_PACKAGES+=	gle
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gle

.if !empty(GLE_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gle+=		gle>=3.0.3
BUILDLINK_ABI_DEPENDS.gle+=	gle>=3.1.0nb2
BUILDLINK_PKGSRCDIR.gle?=	../../graphics/gle
.endif	# GLE_BUILDLINK3_MK

.include "../../graphics/Mesa/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}