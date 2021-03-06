# $NetBSD: buildlink3.mk,v 1.1 2007/09/20 21:03:52 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBXMLPP1_BUILDLINK3_MK:=	${LIBXMLPP1_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	libxmlpp1
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibxmlpp1}
BUILDLINK_PACKAGES+=	libxmlpp1
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libxmlpp1

.if ${LIBXMLPP1_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.libxmlpp1+=	libxml++1>=1.0.5
BUILDLINK_PKGSRCDIR.libxmlpp1?=		../../textproc/libxml++1
.endif	# LIBXMLPP1_BUILDLINK3_MK

.include "../../textproc/libxml2/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
