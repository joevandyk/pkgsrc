# $NetBSD: Makefile,v 1.7 2007/09/25 10:03:52 hira Exp $
#

PKGNAME=		pidgin-${PIDGIN_VERSION}
COMMENT=		Multi-protocol Instant Messaging client GTK frontend

PKG_DESTDIR_SUPPORT=	user-destdir

.include		"../../chat/libpurple/Makefile.common"

USE_DIRS+=		xdg-1.4
USE_TOOLS+=		msgfmt

PKGCONFIG_OVERRIDE+=	gaim.pc.in
PKGCONFIG_OVERRIDE+=	libpurple/purple.pc.in
PKGCONFIG_OVERRIDE+=	pidgin/pidgin.pc.in

CONFIGURE_ARGS+=	--disable-gevolution
CONFIGURE_ARGS+=	--enable-gtkui
CONFIGURE_ARGS+=	--disable-consoleui

BUILD_DIRS=		pidgin

# includes "Arguments to configure" as string
CHECK_WRKREF_SKIP=	bin/pidgin

.include "options.mk"

pre-build:
	# XXX Find a cleaner way.
	${TEST} -r ${WRKSRC}/libpurple/libpurple.la || \
	  ln -s ${BUILDLINK_DIR}/lib/libpurple.la ${WRKSRC}/libpurple/.

.include "../../chat/libpurple/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../graphics/hicolor-icon-theme/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libXScrnSaver/buildlink3.mk"
.include "../../x11/startup-notification/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
