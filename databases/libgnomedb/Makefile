# $NetBSD: Makefile,v 1.64 2007/09/21 13:03:32 wiz Exp $
#

DISTNAME=		libgnomedb-3.0.0
PKGREVISION=		1
CATEGORIES=		databases gnome
MASTER_SITES=		${MASTER_SITE_GNOME:=sources/libgnomedb/3.0/}
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.gnome-db.org/
COMMENT=		GNOME2 database library

USE_TOOLS+=		gmake intltool msgfmt pkg-config
USE_LIBTOOL=		YES
USE_DIRS+=		gnome2-1.5
USE_PKGLOCALEDIR=	YES
GNU_CONFIGURE=		YES

PKGCONFIG_OVERRIDE=	libgnomedb-3.0.pc.in libgnomedb-extra-3.0.pc.in \
			libgnomedb-graph-3.0.pc.in

GCONF_SCHEMAS=		libgnomedb-3.0.schemas

BUILDLINK_API_DEPENDS.libgda+=	libgda>=3.0.0
.include "../../databases/libgda/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/GConf/schemas.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../graphics/libgnomecanvas/buildlink3.mk"
.include "../../textproc/scrollkeeper/omf.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../x11/gtksourceview/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
