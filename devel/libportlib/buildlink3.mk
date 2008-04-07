# $NetBSD: buildlink3.mk,v 1.5 2006/07/08 23:10:45 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBPORTLIB_BUILDLINK3_MK:=	${LIBPORTLIB_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libportlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibportlib}
BUILDLINK_PACKAGES+=	libportlib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libportlib

.if !empty(LIBPORTLIB_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libportlib+=	libportlib>=1.01
BUILDLINK_PKGSRCDIR.libportlib?=	../../devel/libportlib
BUILDLINK_DEPMETHOD.libportlib?=	build
.endif	# LIBPORTLIB_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}