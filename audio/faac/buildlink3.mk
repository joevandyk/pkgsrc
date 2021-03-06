# $NetBSD: buildlink3.mk,v 1.6 2006/07/08 23:10:35 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
FAAC_BUILDLINK3_MK:=	${FAAC_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	faac
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nfaac}
BUILDLINK_PACKAGES+=	faac
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}faac

.if !empty(FAAC_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.faac+=	faac>=1.24
BUILDLINK_ABI_DEPENDS.faac+=	faac>=1.24nb1
BUILDLINK_PKGSRCDIR.faac?=	../../audio/faac
.endif	# FAAC_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
