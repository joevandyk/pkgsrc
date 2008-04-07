# $NetBSD: buildlink3.mk,v 1.2 2007/01/18 17:30:44 joerg Exp $

BUILDLINK_DEPMETHOD.damageproto?=	build

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
DAMAGEPROTO_BUILDLINK3_MK:=	${DAMAGEPROTO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	damageproto
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ndamageproto}
BUILDLINK_PACKAGES+=	damageproto
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}damageproto

.if ${DAMAGEPROTO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.damageproto+=	damageproto>=1.1.0
BUILDLINK_PKGSRCDIR.damageproto?=	../../x11/damageproto
.endif	# DAMAGEPROTO_BUILDLINK3_MK

.include "../../x11/xproto/buildlink3.mk"
.include "../../x11/fixesproto/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
