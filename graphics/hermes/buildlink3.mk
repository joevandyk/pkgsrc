# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:10:51 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
HERMES_BUILDLINK3_MK:=	${HERMES_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	Hermes
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NHermes}
BUILDLINK_PACKAGES+=	Hermes
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}Hermes

.if !empty(HERMES_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.Hermes+=	Hermes>=1.3.2
BUILDLINK_ABI_DEPENDS.Hermes+=	Hermes>=1.3.3nb2
BUILDLINK_PKGSRCDIR.Hermes?=	../../graphics/hermes
.endif	# HERMES_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
