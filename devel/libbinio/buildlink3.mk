# $NetBSD: buildlink3.mk,v 1.1.1.1 2007/09/10 15:50:11 xtraeme Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBBINIO_BUILDLINK3_MK:=	${LIBBINIO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	libbinio
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibbinio}
BUILDLINK_PACKAGES+=	libbinio
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libbinio

.if ${LIBBINIO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.libbinio+=	libbinio>=1.4
BUILDLINK_PKGSRCDIR.libbinio?=		../../devel/libbinio
BUILDLINK_DEPMETHOD.libbinio?=		build
.endif	# LIBBINIO_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
