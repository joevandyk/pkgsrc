# $NetBSD: buildlink3.mk,v 1.9 2007/01/27 10:58:30 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GPSIM_BUILDLINK3_MK:=	${GPSIM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gpsim
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngpsim}
BUILDLINK_PACKAGES+=	gpsim
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gpsim

.if !empty(GPSIM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gpsim+=	gpsim>=20050905
BUILDLINK_ABI_DEPENDS.gpsim+=	gpsim>=20050905nb3
BUILDLINK_PKGSRCDIR.gpsim?=	../../emulators/gpsim-devel
.endif	# GPSIM_BUILDLINK3_MK

.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}