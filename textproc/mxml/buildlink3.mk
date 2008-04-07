# $NetBSD: buildlink3.mk,v 1.1.1.1 2007/10/12 17:30:04 drochner Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
MXML_BUILDLINK3_MK:=	${MXML_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	mxml
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nmxml}
BUILDLINK_PACKAGES+=	mxml
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}mxml

.if ${MXML_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.mxml+=	mxml>=2.3
BUILDLINK_PKGSRCDIR.mxml?=	../../textproc/mxml
.endif	# MXML_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
