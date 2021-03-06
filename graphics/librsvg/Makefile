# $NetBSD: Makefile,v 1.26 2007/09/21 13:03:52 wiz Exp $

DISTNAME=	librsvg-2.18.2
PKGREVISION=	2
CATEGORIES=	graphics gnome
MASTER_SITES=	${MASTER_SITE_GNOME:=sources/librsvg/2.18/}
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	jmmv@NetBSD.org
HOMEPAGE=	http://librsvg.sourceforge.net/
COMMENT=	SVG library for GNOME2

PKG_DESTDIR_SUPPORT=	user-destdir

CONFLICTS+=	librsvg2-gtk-[0-9]* librsvg2-[0-9]*
MAKE_JOBS_SAFE=	NO

USE_DIRS+=		xdg-1.1
USE_LIBTOOL=		yes
USE_TOOLS+=		pkg-config
GNU_CONFIGURE=		yes

PKGCONFIG_OVERRIDE=	librsvg-2.0.pc.in

TEST_TARGET=		check

CONFIGURE_ARGS+=	--with-gimp=no
CONFIGURE_ARGS+=	--with-tags=
CONFIGURE_ARGS+=	--disable-mozilla-plugin

GTK2_LOADERS=		yes

BUILDLINK_API_DEPENDS.cairo+=	cairo>=1.2.0
BUILDLINK_API_DEPENDS.glib2+=	glib2>=2.11.0
BUILDLINK_API_DEPENDS.gtk2+=	gtk2+>=2.6.0

post-install:
	-rmdir -p ${PREFIX}/lib/mozilla/plugins

.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libgsf/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../fonts/fontconfig/buildlink3.mk"
.include "../../print/libgnomeprint/buildlink3.mk"
.include "../../print/libgnomeprintui/buildlink3.mk"
BUILDLINK_API_DEPENDS.libcroco+=	libcroco>=0.6.1
.include "../../sysutils/gnome-vfs/buildlink3.mk"
.include "../../textproc/libcroco/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/modules.mk"
.include "../../mk/bsd.pkg.mk"
