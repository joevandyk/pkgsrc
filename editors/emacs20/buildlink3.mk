# $NetBSD: buildlink3.mk,v 1.1 2007/10/29 12:40:03 uebayasi Exp $
#

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
APEL_BUILDLINK3_MK:=	${APEL_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	emacs
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nemacs}
BUILDLINK_PACKAGES+=	emacs
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}emacs

.if ${APEL_BUILDLINK3_MK} == "+"
.include "../../mk/emacs.mk"
BUILDLINK_API_DEPENDS.emacs+=	${_EMACS_REQD.emacs20}
BUILDLINK_PKGSRCDIR.emacs?=	${_EMACS_DEP.emacs20}
.endif	# APEL_BUILDLINK3_MK

BUILDLINK_CONTENTS_FILTER.emacs=	${EGREP} '.*\.el$$|.*\.elc$$'

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
