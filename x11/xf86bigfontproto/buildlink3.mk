# $NetBSD: buildlink3.mk,v 1.1.1.1 2006/11/03 17:53:21 joerg Exp $

BUILDLINK_DEPMETHOD.xf86bigfontproto?=	build

BUILDLINK_DEPTH:=			${BUILDLINK_DEPTH}+
XF86BIGFONTPROTO_BUILDLINK3_MK:=	${XF86BIGFONTPROTO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	xf86bigfontproto
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nxf86bigfontproto}
BUILDLINK_PACKAGES+=	xf86bigfontproto
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}xf86bigfontproto

.if ${XF86BIGFONTPROTO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.xf86bigfontproto+=	xf86bigfontproto>=1.1
BUILDLINK_PKGSRCDIR.xf86bigfontproto?=	../../x11/xf86bigfontproto
.endif	# XF86BIGFONTPROTO_BUILDLINK3_MK

BUILDLINK_DEPTH:=			${BUILDLINK_DEPTH:S/+$//}