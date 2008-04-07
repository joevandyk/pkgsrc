# $NetBSD: buildlink3.mk,v 1.1 2007/12/16 13:45:59 uebayasi Exp $
#

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
W3_BUILDLINK3_MK:=	${W3_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	w3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nw3}
BUILDLINK_PACKAGES+=	w3
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}w3

.if ${W3_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.w3+=	${EMACS_PKGNAME_PREFIX}w3>=3.99	# 4.0betaX
BUILDLINK_PKGSRCDIR.w3?=	../../www/w3
.endif	# W3_BUILDLINK3_MK

BUILDLINK_CONTENTS_FILTER.w3=	${EGREP} '.*\.el$$|.*\.elc$$'

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
