# $NetBSD: buildlink3.mk,v 1.18 2007/09/19 23:13:17 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
LIBGSF_BUILDLINK3_MK:=	${LIBGSF_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libgsf
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibgsf}
BUILDLINK_PACKAGES+=	libgsf
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libgsf

.if !empty(LIBGSF_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libgsf+=	libgsf>=1.13.3
BUILDLINK_ABI_DEPENDS.libgsf?=	libgsf>=1.14.3nb1
BUILDLINK_PKGSRCDIR.libgsf?=	../../devel/libgsf
.endif	# LIBGSF_BUILDLINK3_MK

.include "../../archivers/bzip2/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../sysutils/gnome-vfs/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
