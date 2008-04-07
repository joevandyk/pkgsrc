# $NetBSD: buildlink3.mk,v 1.4 2007/09/20 21:12:05 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBGTOP_BUILDLINK3_MK:=		${LIBGTOP_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libgtop
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibgtop}
BUILDLINK_PACKAGES+=	libgtop
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libgtop

.if !empty(LIBGTOP_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libgtop+=	libgtop>=2.14.0
BUILDLINK_PKGSRCDIR.libgtop?=	../../sysutils/libgtop
.endif	# LIBGTOP_BUILDLINK3_MK

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/popt/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
