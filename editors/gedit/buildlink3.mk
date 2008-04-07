# $NetBSD: buildlink3.mk,v 1.12 2007/11/03 16:27:40 drochner Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GEDIT_BUILDLINK3_MK:=	${GEDIT_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	gedit
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngedit}
BUILDLINK_PACKAGES+=	gedit
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gedit

.if !empty(GEDIT_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.gedit+=	gedit>=2.12.1nb4
BUILDLINK_ABI_DEPENDS.gedit?=	gedit>=2.18.1nb1
BUILDLINK_PKGSRCDIR.gedit?=	../../editors/gedit
.endif	# GEDIT_BUILDLINK3_MK

.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../print/libgnomeprintui/buildlink3.mk"
.include "../../x11/gtksourceview2/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
