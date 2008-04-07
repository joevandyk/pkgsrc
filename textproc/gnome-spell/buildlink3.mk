# $NetBSD: buildlink3.mk,v 1.18 2007/09/21 13:04:23 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GNOME_SPELL_BUILDLINK3_MK:=	${GNOME_SPELL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gnome-spell
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnome-spell}
BUILDLINK_PACKAGES+=	gnome-spell
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gnome-spell

.if !empty(GNOME_SPELL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gnome-spell+=		gnome-spell>=1.0.5
BUILDLINK_ABI_DEPENDS.gnome-spell+=	gnome-spell>=1.0.7nb1
BUILDLINK_PKGSRCDIR.gnome-spell?=	../../textproc/gnome-spell
.endif	# GNOME_SPELL_BUILDLINK3_MK

.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/libbonoboui/buildlink3.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../net/ORBit2/buildlink3.mk"
.include "../../textproc/aspell/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
