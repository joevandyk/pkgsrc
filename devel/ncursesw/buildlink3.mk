# $NetBSD: buildlink3.mk,v 1.1 2006/10/13 18:07:49 tron Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
NCURSESW_BUILDLINK3_MK:=${NCURSESW_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	ncursesw
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nncursesw}
BUILDLINK_PACKAGES+=	ncursesw
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}ncursesw

.if !empty(NCURSESW_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.ncursesw+=	ncursesw>=5.5
BUILDLINK_ABI_DEPENDS.ncursesw+=	ncursesw>=5.5
BUILDLINK_PKGSRCDIR.ncursesw?=		../../devel/ncursesw
.endif	# NCURSESW_BUILDLINK3_MK

USE_NCURSES=		YES

.include "../../devel/ncurses/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}