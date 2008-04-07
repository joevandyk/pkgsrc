# $NetBSD: buildlink3.mk,v 1.1.1.1 2006/08/15 15:21:27 abs Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GLEW_BUILDLINK3_MK:=	${GLEW_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	glew
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nglew}
BUILDLINK_PACKAGES+=	glew
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}glew

.if !empty(GLEW_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.glew+=	glew>=1.3.4
BUILDLINK_ABI_DEPENDS.glew+=	glew>=1.3.4
BUILDLINK_PKGSRCDIR.glew?=	../../graphics/glew
.endif	# GLEW_BUILDLINK3_MK

.include "../../graphics/MesaLib/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}