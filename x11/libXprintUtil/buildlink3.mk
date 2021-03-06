# $NetBSD: buildlink3.mk,v 1.1.1.1 2007/04/12 15:05:24 joerg Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBXPRINTUTIL_BUILDLINK3_MK:=	${LIBXPRINTUTIL_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	libXprintUtil
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NlibXprintUtil}
BUILDLINK_PACKAGES+=	libXprintUtil
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libXprintUtil

.if ${LIBXPRINTUTIL_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.libXprintUtil+=	libXprintUtil>=1.0.1
BUILDLINK_PKGSRCDIR.libXprintUtil?=	../../x11/libXprintUtil
.endif	# LIBXPRINTUTIL_BUILDLINK3_MK

.include "../../x11/libXp/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
