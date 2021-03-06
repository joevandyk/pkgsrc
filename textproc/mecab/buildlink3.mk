# $NetBSD: buildlink3.mk,v 1.1.1.1 2007/05/12 13:48:24 obache Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
MECAB_BUILDLINK3_MK:=	${MECAB_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	mecab
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nmecab}
BUILDLINK_PACKAGES+=	mecab
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}mecab

.if ${MECAB_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.mecab+=	mecab>=0.90
BUILDLINK_PKGSRCDIR.mecab?=	../../textproc/mecab
.endif	# MECAB_BUILDLINK3_MK

.include "../../textproc/mecab-base/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
