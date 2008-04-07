# $NetBSD: buildlink3.mk,v 1.1 2007/10/29 12:41:17 uebayasi Exp $
#

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
ELIB_BUILDLINK3_MK:=	${ELIB_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	elib
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nelib}
BUILDLINK_PACKAGES+=	elib
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}elib

.if ${ELIB_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.elib+=	${EMACS_PKGNAME_PREFIX}elib>=1
BUILDLINK_PKGSRCDIR.elib?=	../../devel/elib
.endif	# ELIB_BUILDLINK3_MK

BUILDLINK_CONTENTS_FILTER.elib=	${EGREP} '.*\.el$$|.*\.elc$$'

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}