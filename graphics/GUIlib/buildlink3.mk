# $NetBSD: buildlink3.mk,v 1.9 2006/07/08 23:10:50 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GUILIB_BUILDLINK3_MK:=	${GUILIB_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	GUIlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NGUIlib}
BUILDLINK_PACKAGES+=	GUIlib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}GUIlib

.if !empty(GUILIB_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.GUIlib+=	GUIlib>=1.1.0nb2
BUILDLINK_ABI_DEPENDS.GUIlib+=	GUIlib>=1.1.0nb7
BUILDLINK_PKGSRCDIR.GUIlib?=	../../graphics/GUIlib
.endif	# GUILIB_BUILDLINK3_MK

.include "../../devel/SDL/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}