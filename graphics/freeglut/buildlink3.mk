# $NetBSD: buildlink3.mk,v 1.7 2006/07/08 23:10:51 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
FREEGLUT_BUILDLINK3_MK:=	${FREEGLUT_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	freeglut
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfreeglut}
BUILDLINK_PACKAGES+=	freeglut
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}freeglut

.if !empty(FREEGLUT_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.freeglut+=	freeglut>=2.2.0
BUILDLINK_ABI_DEPENDS.freeglut+=	freeglut>=2.2.0nb3
BUILDLINK_PKGSRCDIR.freeglut?=	../../graphics/freeglut
.endif	# FREEGLUT_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
