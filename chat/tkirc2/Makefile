# $NetBSD: Makefile,v 1.11 2007/09/19 06:46:51 tron Exp $

DISTNAME=	tkirc2.46
PKGNAME=	tkirc2-2.46
PKGREVISION=	2
CATEGORIES=	chat x11
MASTER_SITES=	ftp://ftp.netsplit.de/pub/tcltk/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://netsplit.de/tkirc2/
COMMENT=	GUI for the ircII Internet Relay Chat client

DEPENDS+=	ircII-[0-9]*:../../chat/ircII
DEPENDS+=	tk>=8.3.2:../../x11/tk

PKG_INSTALLATION_TYPES=	overwrite pkgviews

WRKSRC=		${WRKDIR}/tkirc2
NO_CONFIGURE=	yes
NO_BUILD=	yes

SUBST_CLASSES+=		paths
SUBST_MESSAGE.paths=	Fixing hardcoded command names.
SUBST_STAGE.paths=	post-patch
SUBST_FILES.paths=	tkirc2
SUBST_SED.paths=	-e 's,wish8.3,wish,g'

INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/tkirc2 ${PREFIX}/bin
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/tkirc2
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/tkirc2/scripts
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/share/doc/tkirc2
	${INSTALL_DATA} ${WRKSRC}/CHANGES ${PREFIX}/share/doc/tkirc2
	${INSTALL_DATA} ${WRKSRC}/COPYING ${PREFIX}/share/doc/tkirc2
	${INSTALL_SCRIPT} ${WRKSRC}/.tkirc2/scripts/* \
	  ${PREFIX}/share/examples/tkirc2/scripts
	${INSTALL_DATA} ${WRKSRC}/.tkirc2/netscape.sh \
	  ${PREFIX}/share/examples/tkirc2
	${INSTALL_DATA} ${WRKSRC}/.tkirc2/tkircrc-example \
	   ${PREFIX}/share/examples/tkirc2

.include "../../mk/bsd.pkg.mk"
