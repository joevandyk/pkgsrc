# $NetBSD: buildlink3.mk,v 1.13 2007/10/10 15:20:50 rillig Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
PWLIB_BUILDLINK3_MK:=	${PWLIB_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	pwlib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npwlib}
BUILDLINK_PACKAGES+=	pwlib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}pwlib

.if !empty(PWLIB_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.pwlib+=	pwlib>=1.8.3nb1
BUILDLINK_ABI_DEPENDS.pwlib?=	pwlib>=1.8.3nb6
BUILDLINK_PKGSRCDIR.pwlib?=	../../devel/pwlib
.endif	# PWLIB_BUILDLINK3_MK

.include "../../security/openssl/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
