# $NetBSD: Makefile,v 1.4 2007/02/19 07:57:25 joerg Exp $
#

DISTNAME=		font-bh-ttf-1.0.0
CATEGORIES=		fonts
MASTER_SITES=		http://xorg.freedesktop.org/releases/individual/font/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		joerg@NetBSD.org
HOMEPAGE=		http://xorg.freedesktop.org/
COMMENT=		Standard Bigelow & Holmes TrueType fonts

PKG_DESTDIR_SUPPORT=	user-destdir

GNU_CONFIGURE=		yes
CONFIGURE_ENV+=		FCCACHE=${TOOLS_CMD.true:Q}

FONTS_DIRS.ttf=		lib/X11/fonts/TTF
FONTS_DIRS.x11=		lib/X11/fonts/TTF

INSTALLATION_DIRS=	share/doc/font-bh-ttf

post-install:
	${INSTALL_DATA} ${WRKSRC}/COPYING ${DESTDIR}${PREFIX}/share/doc/font-bh-ttf

.include "../../mk/bsd.pkg.mk"
