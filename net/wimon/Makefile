# $NetBSD: Makefile,v 1.9 2007/02/22 19:27:01 wiz Exp $
#

DISTNAME=	wimon-0.3
PKGREVISION=	1
CATEGORIES=	net
MASTER_SITES=	http://imil.net/wimon/

MAINTAINER=	imil@gcu.info
HOMEPAGE=	http://imil.net/wimon/
COMMENT=	Tool that shows a real-time graph of your wireless connection

PKG_INSTALLATION_TYPES=	overwrite pkgviews

ONLY_FOR_PLATFORM=	FreeBSD-*-* NetBSD-*-* OpenBSD-*-* DragonFly-*-*
# Needs net80211/*.h header files which appeared in 1.6ZD.
NOT_FOR_PLATFORM=	NetBSD-0*-* NetBSD-1.[012345]*-* NetBSD-1.6[-_.]*-*
NOT_FOR_PLATFORM+=	NetBSD-1.6[A-Z]-* NetBSD-1.6Z[A-C]*-*

WRKSRC=		${WRKDIR}/wimon

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man8

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/wimon ${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/wimon.8 ${PREFIX}/${PKGMANDIR}/man8

.include "../../devel/ncurses/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
