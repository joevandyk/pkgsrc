# $NetBSD: buildlink3.mk,v 1.11 2006/07/08 23:10:57 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBESMTP_BUILDLINK3_MK:=	${LIBESMTP_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libesmtp
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibesmtp}
BUILDLINK_PACKAGES+=	libesmtp
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libesmtp

.if !empty(LIBESMTP_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libesmtp+=	libesmtp>=1.0rc1nb1
BUILDLINK_ABI_DEPENDS.libesmtp?=	libesmtp>=1.0.3nb2
BUILDLINK_PKGSRCDIR.libesmtp?=	../../mail/libesmtp

LIBESMTP=	-lesmtp

CONFIGURE_ENV+=	LIBESMTP=${LIBESMTP:Q}
MAKE_ENV+=	LIBESMTP=${LIBESMTP:Q}

.endif	# LIBESMTP_BUILDLINK3_MK

.include "../../security/openssl/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
