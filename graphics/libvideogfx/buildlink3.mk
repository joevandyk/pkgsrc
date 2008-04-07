# $NetBSD: buildlink3.mk,v 1.9 2007/02/07 23:54:48 joerg Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LIBVIDEOGFX_BUILDLINK3_MK:=	${LIBVIDEOGFX_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	libvideogfx
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlibvideogfx}
BUILDLINK_PACKAGES+=	libvideogfx
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}libvideogfx

.if !empty(LIBVIDEOGFX_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.libvideogfx+=	libvideogfx>=1.0.3
BUILDLINK_ABI_DEPENDS.libvideogfx+=	libvideogfx>=1.0.3nb3
BUILDLINK_PKGSRCDIR.libvideogfx?=	../../graphics/libvideogfx
.endif	# LIBVIDEOGFX_BUILDLINK3_MK

.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
