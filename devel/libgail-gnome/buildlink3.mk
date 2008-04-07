# $NetBSD: buildlink3.mk,v 1.16 2007/06/05 05:37:14 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBGAIL_GNOME_BUILDLINK3_MK:=	${LIBGAIL_GNOME_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libgail-gnome
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibgail-gnome}
BUILDLINK_PACKAGES+=	libgail-gnome
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libgail-gnome

.if !empty(LIBGAIL_GNOME_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libgail-gnome+=	libgail-gnome>=1.1.1nb2
BUILDLINK_ABI_DEPENDS.libgail-gnome?=	libgail-gnome>=1.1.3nb5
BUILDLINK_PKGSRCDIR.libgail-gnome?=	../../devel/libgail-gnome
.endif	# LIBGAIL_GNOME_BUILDLINK3_MK

.include "../../devel/at-spi/buildlink3.mk"
.include "../../devel/atk/buildlink3.mk"
.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/libbonoboui/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../x11/gnome-panel/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
