# $NetBSD: buildlink3.mk,v 1.2 2007/09/21 13:03:34 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
EEL_BUILDLINK3_MK:=	${EEL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	eel
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Neel}
BUILDLINK_PACKAGES+=	eel
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}eel

.if !empty(EEL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.eel+=	eel>=2.10.0
BUILDLINK_ABI_DEPENDS.eel?=	eel>=2.18.0.1nb1
BUILDLINK_PKGSRCDIR.eel?=	../../devel/eel
.endif	# EEL_BUILDLINK3_MK

.include "../../devel/GConf/buildlink3.mk"
.include "../../devel/gail/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/libgnome/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../graphics/libart/buildlink3.mk"
.include "../../sysutils/gnome-menus/buildlink3.mk"
.include "../../sysutils/gnome-vfs/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gnome-desktop/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
