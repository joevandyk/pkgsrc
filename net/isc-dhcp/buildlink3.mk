# $NetBSD: buildlink3.mk,v 1.2 2007/12/13 02:54:49 taca Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
ISC_DHCP_BASE_BUILDLINK3_MK:=	${ISC_DHCP_BASE_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	isc-dhcp-base
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nisc-dhcp-base}
BUILDLINK_PACKAGES+=	isc-dhcp-base
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}isc-dhcp-base

.if ${ISC_DHCP_BASE_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.isc-dhcp-base+=	isc-dhcp-base>=3.1.0
BUILDLINK_PKGSRCDIR.isc-dhcp-base?=	../../net/isc-dhcp
.endif	# ISC_DHCP_BASE_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
