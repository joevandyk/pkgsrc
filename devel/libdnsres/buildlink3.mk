# $NetBSD: buildlink3.mk,v 1.4 2006/07/08 23:10:44 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBDNSRES_BUILDLINK3_MK:=	${LIBDNSRES_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libdnsres
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibdnsres}
BUILDLINK_PACKAGES+=	libdnsres
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libdnsres

.if !empty(LIBDNSRES_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libdnsres+=	libdnsres>=0.1a
BUILDLINK_PKGSRCDIR.libdnsres?=	../../devel/libdnsres
.endif	# LIBDNSRES_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
