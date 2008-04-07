# $NetBSD: buildlink3.mk,v 1.12 2006/07/08 23:11:07 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBKSBA_BUILDLINK3_MK:=	${LIBKSBA_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libksba
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibksba}
BUILDLINK_PACKAGES+=	libksba
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libksba

.if !empty(LIBKSBA_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libksba+=	libksba>=0.9.7
BUILDLINK_ABI_DEPENDS.libksba+=	libksba>=0.9.13nb1
BUILDLINK_PKGSRCDIR.libksba?=	../../security/libksba
.endif	# LIBKSBA_BUILDLINK3_MK

.include "../../security/libgcrypt/buildlink3.mk"
.include "../../security/libgpg-error/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
