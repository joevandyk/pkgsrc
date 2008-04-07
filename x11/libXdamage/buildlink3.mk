# $NetBSD: buildlink3.mk,v 1.2 2006/12/17 23:02:25 joerg Exp $

.include "../../mk/bsd.fast.prefs.mk"

.if ${X11_TYPE} != "modular"
.include "../../mk/x11.buildlink3.mk"
.else

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBXDAMAGE_BUILDLINK3_MK:=	${LIBXDAMAGE_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	libXdamage
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NlibXdamage}
BUILDLINK_PACKAGES+=	libXdamage
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libXdamage

.if ${LIBXDAMAGE_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.libXdamage+=	libXdamage>=1.0.3
BUILDLINK_PKGSRCDIR.libXdamage?=	../../x11/libXdamage
.endif	# LIBXDAMAGE_BUILDLINK3_MK

.include "../../x11/damageproto/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXfixes/buildlink3.mk"
.include "../../x11/xproto/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}

.endif
