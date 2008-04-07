# $NetBSD: buildlink3.mk,v 1.14 2007/10/27 13:55:26 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBETPAN_BUILDLINK3_MK:=	${LIBETPAN_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libetpan
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibetpan}
BUILDLINK_PACKAGES+=	libetpan
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libetpan

.if !empty(LIBETPAN_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libetpan+=	libetpan>=0.38nb1
BUILDLINK_ABI_DEPENDS.libetpan?=	libetpan>=0.52
BUILDLINK_PKGSRCDIR.libetpan?=	../../mail/libetpan
.endif	# LIBETPAN_BUILDLINK3_MK

.include "../../converters/libiconv/buildlink3.mk"
.include "../../databases/db4/buildlink3.mk"
.include "../../security/cyrus-sasl/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../textproc/expat/buildlink3.mk"
.include "../../www/curl/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
