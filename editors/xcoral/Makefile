# $NetBSD: Makefile,v 1.15 2007/01/30 23:06:18 joerg Exp $

DISTNAME=		xcoral-3.2
PKGREVISION=		1
CATEGORIES=		editors
MASTER_SITES=		${MASTER_SITE_XCONTRIB:=editors/}

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Multiwindow mouse-based text editor for X

USE_X11BASE=	yes
GNU_CONFIGURE=	yes

LIBFILES=	DEPEND README cmd.sc color.sc comments.sc compare-win.sc \
		complete-word.sc describe.sc edir.sc edt.sc example.sc \
		french.sc hack-filename.sc hanoi.sc head.sc html.sc \
		java.sc keydef-ext.sc latex-macros.sc latex.sc \
		man.dtex misc-commands.sc mode-ext.sc mode.sc mouse.sc \
		rcs.sc save.sc sun-keydef.sc title.sc top-ten.sc \
		utilities.sc version.sc window-utilities.sc xcoralrc.lf

INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/lib/xcoral
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/xcoral/HTML/icons
	${INSTALL_PROGRAM} ${WRKSRC}/xcoral ${PREFIX}/bin
.for FILE in ${LIBFILES}
	${INSTALL_DATA} ${WRKSRC}/SmacLib/${FILE} ${PREFIX}/lib/xcoral
.endfor
	${CP} -r ${WRKSRC}/Doc/* ${PREFIX}/share/doc/xcoral

BUILDLINK_DEPMETHOD.libXt?=	build

.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
