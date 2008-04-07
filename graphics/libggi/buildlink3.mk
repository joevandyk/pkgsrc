# $NetBSD: buildlink3.mk,v 1.11 2007/02/04 15:26:34 joerg Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBGGI_BUILDLINK3_MK:=	${LIBGGI_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libggi
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibggi}
BUILDLINK_PACKAGES+=	libggi
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libggi

.if !empty(LIBGGI_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libggi+=	libggi>=2.1.0
BUILDLINK_ABI_DEPENDS.libggi?=	libggi>=2.1.1nb1
BUILDLINK_PKGSRCDIR.libggi?=	../../graphics/libggi
.endif	# LIBGGI_BUILDLINK3_MK

.include "../../mk/bsd.fast.prefs.mk"

.if ${X11_TYPE} == "modular"
.include "../../x11/libXxf86vm/buildlink3.mk"
.endif

.include "../../devel/ncurses/buildlink3.mk"
.include "../../graphics/libgii/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../x11/xextproto/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
