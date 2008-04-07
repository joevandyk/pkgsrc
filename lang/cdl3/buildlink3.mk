# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:10:54 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
CDL3_BUILDLINK3_MK:=	${CDL3_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	cdl3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ncdl3}
BUILDLINK_PACKAGES+=	cdl3
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}cdl3

.if !empty(CDL3_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.cdl3+=	cdl3>=1.2.5
BUILDLINK_ABI_DEPENDS.cdl3?=	cdl3>=1.2.5nb1
BUILDLINK_PKGSRCDIR.cdl3?=	../../lang/cdl3
.endif	# CDL3_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
