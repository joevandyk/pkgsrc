# $NetBSD: buildlink3.mk,v 1.17 2006/11/19 11:50:23 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
CURL_BUILDLINK3_MK:=	${CURL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	curl
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncurl}
BUILDLINK_PACKAGES+=	curl
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}curl

.if !empty(CURL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.curl+=	curl>=7.12.3
BUILDLINK_ABI_DEPENDS.curl+=	curl>=7.16.0
BUILDLINK_PKGSRCDIR.curl?=	../../www/curl
.endif	# CURL_BUILDLINK3_MK

.include "../../devel/libidn/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
