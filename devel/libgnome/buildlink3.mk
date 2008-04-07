# $NetBSD: buildlink3.mk,v 1.18 2007/09/19 23:13:16 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBGNOME_BUILDLINK3_MK:=	${LIBGNOME_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libgnome
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibgnome}
BUILDLINK_PACKAGES+=	libgnome
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libgnome

.if !empty(LIBGNOME_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libgnome+=	libgnome>=2.8.0
BUILDLINK_ABI_DEPENDS.libgnome+=	libgnome>=2.18.0nb1
BUILDLINK_PKGSRCDIR.libgnome?=	../../devel/libgnome
.endif	# LIBGNOME_BUILDLINK3_MK

.include "../../audio/esound/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/popt/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../sysutils/gnome-vfs/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../textproc/libxslt/buildlink3.mk"
.include "../../mk/bdb.buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
