# $NetBSD: buildlink3.mk,v 1.15 2007/08/07 10:25:11 tnn Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LESSTIF_BUILDLINK3_MK:=	${LESSTIF_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	lesstif
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlesstif}
BUILDLINK_PACKAGES+=	lesstif
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}lesstif

.if !empty(LESSTIF_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.lesstif+=	lesstif>=0.95.0nb1
BUILDLINK_ABI_DEPENDS.lesstif+=	lesstif>=0.94.4nb2
BUILDLINK_PKGSRCDIR.lesstif?=	../../x11/lesstif
.endif	# LESSTIF_BUILDLINK3_MK

.include "../../fonts/fontconfig/buildlink3.mk"
.include "../../x11/libXrender/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.include "../../x11/printproto/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
