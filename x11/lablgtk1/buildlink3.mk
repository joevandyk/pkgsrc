# $NetBSD: buildlink3.mk,v 1.1 2007/09/21 13:00:55 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LABLGTK1_BUILDLINK3_MK:=	${LABLGTK1_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	lablgtk1
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlablgtk1}
BUILDLINK_PACKAGES+=	lablgtk1
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}lablgtk1

.if !empty(LABLGTK1_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.lablgtk1+=	lablgtk1>=1.2.5nb3
BUILDLINK_ABI_DEPENDS.lablgtk1?=	lablgtk1>=1.2.7nb2
BUILDLINK_PKGSRCDIR.lablgtk1?=		../../x11/lablgtk1
.endif	# LABLGTK1_BUILDLINK3_MK

.include "../../x11/gtk/buildlink3.mk"
.include "../../lang/ocaml/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}