# $NetBSD: buildlink3.mk,v 1.10 2007/09/21 13:03:38 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBGLADEMM_BUILDLINK3_MK:=	${LIBGLADEMM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libglademm
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibglademm}
BUILDLINK_PACKAGES+=	libglademm
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libglademm

.if !empty(LIBGLADEMM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libglademm+=	libglademm>=2.6.0
BUILDLINK_ABI_DEPENDS.libglademm+=	libglademm>=2.6.2nb1
BUILDLINK_PKGSRCDIR.libglademm?=	../../devel/libglademm
.endif	# LIBGLADEMM_BUILDLINK3_MK

.include "../../devel/libglade/buildlink3.mk"
.include "../../x11/gtkmm/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
