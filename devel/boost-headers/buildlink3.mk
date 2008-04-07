# $NetBSD: buildlink3.mk,v 1.8 2006/07/08 23:10:41 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
BOOST_HEADERS_BUILDLINK3_MK:=	${BOOST_HEADERS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	boost-headers
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nboost-headers}
BUILDLINK_PACKAGES+=	boost-headers
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}boost-headers

.if !empty(BOOST_HEADERS_BUILDLINK3_MK:M+)
# Use a dependency pattern that guarantees the proper ABI.
BUILDLINK_API_DEPENDS.boost-headers+=	boost-headers-1.33.*
BUILDLINK_DEPMETHOD.boost-headers?=	build
BUILDLINK_PKGSRCDIR.boost-headers?=	../../devel/boost-headers
.endif	# BOOST_HEADERS_BUILDLINK3_MK

PTHREAD_OPTS+=		require
.include "../../mk/pthread.buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
