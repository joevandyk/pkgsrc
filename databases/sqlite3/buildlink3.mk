# $NetBSD: buildlink3.mk,v 1.7 2007/11/15 10:39:18 rillig Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
SQLITE3_BUILDLINK3_MK:=	${SQLITE3_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	sqlite3
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nsqlite3}
BUILDLINK_PACKAGES+=	sqlite3
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}sqlite3

.if !empty(SQLITE3_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.sqlite3+=	sqlite3>=3.0.8
BUILDLINK_ABI_DEPENDS.sqlite3+=	sqlite3>=3.2.7nb1
BUILDLINK_PKGSRCDIR.sqlite3?=	../../databases/sqlite3
.endif	# SQLITE3_BUILDLINK3_MK

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}