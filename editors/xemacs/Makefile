# $NetBSD: Makefile,v 1.83 2007/02/15 14:27:48 joerg Exp $

.include "../../editors/xemacs/Makefile.common"

MAINTAINER=	uebayasi@NetBSD.org
PKGREVISION=	3

CONFIGURE_ARGS+=	--site-includes=${BUILDLINK_DIR}/include:${BUILDLINK_X11_DIR}/include
CONFIGURE_ARGS+=	--site-libraries=${BUILDLINK_DIR}/lib:${BUILDLINK_X11_DIR}
CONFIGURE_ARGS+=	--site-runtime-libraries=${LOCALBASE}/lib:${X11BASE}/lib

PLIST_SUBST+=	X11ONLY=""

.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../graphics/tiff/buildlink3.mk"
.include "../../x11/libXpm/buildlink3.mk"
.include "../../x11/xbitmaps/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
