# $NetBSD: Makefile,v 1.52 2007/09/21 13:03:29 wiz Exp $

PKG_DESTDIR_SUPPORT=	user-destdir

.include "Makefile.common"

PKGREVISION=	1

MAINTAINER=	tron@NetBSD.org
COMMENT=	X11 (X Window System) IRC client, using the GTK2 toolkit

CONFLICTS=		xchat-gnome-[0-9]*

USE_TOOLS+=		msgfmt
USE_PKGLOCALEDIR=	YES
USE_DIRS+=		xdg-1.1
GCONF_SCHEMAS=		apps_xchat_url_handler.schemas

CONFIGURE_ARGS+=	--enable-tcl=no
CONFIGURE_ARGS+=	--disable-perl
CONFIGURE_ARGS+=	--disable-python
CONFIGURE_ARGS+=	--enable-xft

LDFLAGS.IRIX+=		-lX11

.include "../../mk/bsd.prefs.mk"
.include "options.mk"

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../sysutils/desktop-file-utils/desktopdb.mk"
BUILDLINK_API_DEPENDS.gtk2+=	gtk2+>=2.10.0
.include "../../x11/gtk2/buildlink3.mk"

.if ${OPSYS} == "Darwin"
INSTALL_UNSTRIPPED=	YES

.if empty(PKG_BUILD_OPTIONS.gtk2:Mquartz)
LDFLAGS.Darwin+=	-lX11
.else
CONFIGURE_ARGS+=	--disable-xlib
.endif
.endif

INSTALLATION_DIRS+=	share/doc/xchat lib/xchat/plugins

post-install:
	${INSTALL_DATA} ${WRKSRC}/README ${DESTDIR}${PREFIX}/share/doc/xchat/
	${INSTALL_DATA} ${WRKSRC}/faq.html ${DESTDIR}${PREFIX}/share/doc/xchat/
	${INSTALL_DATA} ${WRKSRC}/plugins/plugin20.html \
		${DESTDIR}${PREFIX}/share/doc/xchat/

.if !empty(PKG_OPTIONS:Mgnome)

	${INSTALL_DATA_DIR} ${DESTDIR}${GCONF_SCHEMAS_DIR}
# In case there're ever additional schema files, use ODE loop.
	${GCONF_SCHEMAS:@.s.@${INSTALL_DATA} ${WRKSRC}/src/common/dbus/${.s.} \
		${DESTDIR}${GCONF_SCHEMAS_DIR}/@}
.endif

.include "../../mk/bsd.pkg.mk"
