# $NetBSD: buildlink3.mk,v 1.3 2007/12/16 19:38:25 tron Exp $

.include "../../mk/bsd.fast.prefs.mk"

.if ${X11_TYPE} != "modular" && !exists(${X11BASE}/lib/pkgconfig/xrender.pc)
.include "../../x11/Xrender/buildlink3.mk"
.else

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBXRENDER_BUILDLINK3_MK:=	${LIBXRENDER_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	libXrender
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NlibXrender}
BUILDLINK_PACKAGES+=	libXrender
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libXrender

.if ${LIBXRENDER_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.libXrender+=	libXrender>=0.9.2
BUILDLINK_PKGSRCDIR.libXrender?=	../../x11/libXrender
.endif	# LIBXRENDER_BUILDLINK3_MK

.include "../../x11/renderproto/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}

.endif
