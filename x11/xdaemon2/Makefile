# $NetBSD: Makefile,v 1.15 2006/03/02 22:58:56 hubertf Exp $

DISTNAME=	xdaemon-2.1
CATEGORIES=	games x11
MASTER_SITES=	${MASTER_SITE_LOCAL}
DISTFILES=	${IMAGES:=.png} Daemon.README

MAINTAINER=	hubertf@NetBSD.org
HOMEPAGE=	http://www.NetBSD.org/
COMMENT=	BSD Daemon sticking on your desktop (like xteddy)

DEPENDS+=	xteddy-2.*:../../x11/xteddy2

CONFLICTS+=	xdaemon-1.*

NO_CONFIGURE=	yes
NO_BUILD=	yes
NO_MTREE=	yes
DIST_SUBDIR=	xdaemon

IMAGES=		xdaemon xdaemon2 xnetbsd-flag xnetbsd-flag2

INSTALLATION_DIRS=	bin share/doc share/xteddy

do-extract:
	@${MKDIR} ${WRKSRC}
	@${ECHO} Bringing daemonic powers to you!

do-install:
.for img in ${IMAGES}
	${INSTALL_DATA} ${DISTDIR}/${DIST_SUBDIR}/${img}.png ${PREFIX}/share/xteddy/${img}.png
	${RM} -f ${PREFIX}/bin/${img}
	${LN} -s xteddy ${PREFIX}/bin/${img}
.endfor
	${INSTALL_DATA} ${DISTDIR}/${DIST_SUBDIR}/Daemon.README ${PREFIX}/share/doc/xdaemon.README

.include "../../mk/bsd.pkg.mk"
