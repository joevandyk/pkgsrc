# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:10:50 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
CAMLIMAGES_BUILDLINK3_MK:=	${CAMLIMAGES_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	camlimages
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncamlimages}
BUILDLINK_PACKAGES+=	camlimages
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}camlimages

.if !empty(CAMLIMAGES_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.camlimages+=	camlimages>=2.2.0
BUILDLINK_ABI_DEPENDS.camlimages?=	camlimages>=2.2.0nb1
BUILDLINK_PKGSRCDIR.camlimages?=	../../graphics/camlimages
.endif	# CAMLIMAGES_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}