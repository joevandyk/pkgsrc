# $NetBSD: Makefile,v 1.8 2007/02/01 22:31:12 joerg Exp $
#

DISTNAME=	weewm-0.0.2
PKGREVISION=	1
CATEGORIES=	wm
MASTER_SITES=	http://www.weewm.org/download/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	minskim@NetBSD.org
HOMEPAGE=	http://www.weewm.org/
COMMENT=	Fast and ultra light windowmanager with total keyboard control


EXAMPLESDIR=	${PREFIX}/share/examples/weewm
DOCDIR=		${PREFIX}/share/doc/weewm

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man1

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/src/weewm ${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/weewm.1 ${PREFIX}/${PKGMANDIR}/man1
	${INSTALL_DATA_DIR} ${EXAMPLESDIR}
	${INSTALL_DATA} ${WRKSRC}/examples/config.rc ${EXAMPLESDIR}
	${INSTALL_DATA} ${WRKSRC}/examples/keys.rc ${EXAMPLESDIR}
	${INSTALL_DATA_DIR} ${DOCDIR}
.for f in AUTHORS FAQ README
	${INSTALL_DATA} ${WRKSRC}/${f} ${DOCDIR}
.endfor

.include "../../x11/libX11/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
