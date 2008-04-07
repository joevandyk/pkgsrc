# $NetBSD: buildlink3.mk,v 1.44 2006/12/12 21:52:37 joerg Exp $

.include "../../mk/bsd.fast.prefs.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
XRENDER_BUILDLINK3_MK:=	${XRENDER_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	Xrender
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NXrender}
BUILDLINK_PACKAGES+=	Xrender
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}Xrender

.if !empty(XRENDER_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.Xrender+=	Xrender>=0.2
BUILDLINK_ABI_DEPENDS.Xrender+=	Xrender>=0.9.0nb1
BUILDLINK_PKGSRCDIR.Xrender?=	../../x11/Xrender
.endif	# XRENDER_BUILDLINK3_MK

.include "../../mk/x11.buildlink3.mk"
.include "../../x11/renderproto/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
