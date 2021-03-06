# $NetBSD: Makefile,v 1.46 2007/11/25 12:41:36 wiz Exp $

DISTNAME=	openbox-3.4.4
PKGREVISION=	1
CATEGORIES=	wm x11
MASTER_SITES=	http://icculus.org/openbox/releases/
# PR pkg/36489
MASTER_SITES+=	http://offload1.icculus.org/openbox/releases/

MAINTAINER=	wiz@NetBSD.org
HOMEPAGE=	http://icculus.org/openbox/
COMMENT=	Standards compliant, light-weight and extensible window manager

DEPENDS+=		vera-ttf>=1.10:../../fonts/vera-ttf

GNU_CONFIGURE=		YES
USE_DIRS+=		gnome2-1.5 xdg-1.4
USE_TOOLS+=		gmake msgfmt pkg-config
USE_LIBTOOL=		YES
USE_PKGLOCALEDIR=	YES

PKGCONFIG_OVERRIDE=	parser/obparser-3.0.pc.in
PKGCONFIG_OVERRIDE+=	render/obrender-3.0.pc.in

CONFIGURE_ARGS+=	--sysconfdir=${PKG_SYSCONFDIR:Q}
LDFLAGS+=		${BUILDLINK_LDADD.libsetenv}
PKG_SYSCONFSUBDIR=	xdg
OWN_DIRS=		${PKG_SYSCONFDIR}
OWN_DIRS+=		${PKG_SYSCONFDIR}/openbox

EGDIR=			${PREFIX}/share/examples/openbox
CONF_FILES=		${EGDIR}/menu.xml ${PKG_SYSCONFDIR}/openbox/menu.xml
CONF_FILES+=		${EGDIR}/rc.xml ${PKG_SYSCONFDIR}/openbox/rc.xml

BUILDLINK_DEPMETHOD.libXt?=	build

.include "../../converters/libiconv/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libsetenv/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXcursor/buildlink3.mk"
.include "../../x11/libXft/buildlink3.mk"
.include "../../x11/libXinerama/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.include "../../x11/startup-notification/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
