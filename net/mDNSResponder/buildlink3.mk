# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:11:04 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
MDNSRESPONDER_BUILDLINK3_MK:=	${MDNSRESPONDER_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	mDNSResponder
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:NmDNSResponder}
BUILDLINK_PACKAGES+=	mDNSResponder
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}mDNSResponder

.if !empty(MDNSRESPONDER_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.mDNSResponder+=	mDNSResponder>=98
BUILDLINK_ABI_DEPENDS.mDNSResponder?=	mDNSResponder>=107.5nb1
BUILDLINK_PKGSRCDIR.mDNSResponder?=	../../net/mDNSResponder
.endif	# MDNSRESPONDER_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
