# $NetBSD: Makefile,v 1.21 2007/10/05 22:38:24 joerg Exp $
#

DISTNAME=	wideangle
PKGNAME=	gimp2-wideangle-1.0
PKGREVISION=	12
CATEGORIES=	graphics
MASTER_SITES=	http://members.ozemail.com.au/~hodsond/
EXTRACT_SUFX=	.c

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://members.ozemail.com.au/~hodsond/wideangle.html
COMMENT=	GIMP plugin for wideangle lens distortions

USE_TOOLS+=	pkg-config

DIST_SUBDIR=	${PKGNAME_NOREV}
WRKSRC=		${WRKDIR}

LINK_PTHREAD=	${PTHREAD_LDFLAGS} ${PTHREAD_LIBS}

do-build:
	(cd ${WRKSRC} && LIBS=${LINK_PTHREAD:Q} gimptool-2.0 --build wideangle.c)

do-install:
	(cd ${WRKSRC} && gimptool-2.0 --install-admin-bin wideangle)

.include "../../graphics/gimp/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
