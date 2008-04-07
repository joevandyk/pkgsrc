# $NetBSD: buildlink3.mk,v 1.1.1.1 2006/11/14 15:52:42 joerg Exp $

BUILDLINK_DEPMETHOD.xf86driproto?=	build

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
XF86DRIPROTO_BUILDLINK3_MK:=	${XF86DRIPROTO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	xf86driproto
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nxf86driproto}
BUILDLINK_PACKAGES+=	xf86driproto
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}xf86driproto

.if ${XF86DRIPROTO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.xf86driproto+=	xf86driproto>=2.0.3
BUILDLINK_PKGSRCDIR.xf86driproto?=	../../x11/xf86driproto
.endif	# XF86DRIPROTO_BUILDLINK3_MK

.include "../../x11/glproto/buildlink3.mk"
.include "../../x11/libdrm/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
