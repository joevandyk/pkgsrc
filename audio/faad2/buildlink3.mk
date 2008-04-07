# $NetBSD: buildlink3.mk,v 1.11 2006/07/08 23:10:35 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FAAD2_BUILDLINK3_MK:=	${FAAD2_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	faad2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfaad2}
BUILDLINK_PACKAGES+=	faad2
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}faad2

.if !empty(FAAD2_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.faad2+=	faad2>=2.0nb3
BUILDLINK_ABI_DEPENDS.faad2?=	faad2>=2.0nb5
BUILDLINK_PKGSRCDIR.faad2?=	../../audio/faad2
BUILDLINK_INCDIRS.faad2?=	include/faad2
.endif	# FAAD2_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}