# $NetBSD: Makefile,v 1.6 2007/03/19 16:40:28 tv Exp $
#

DISTNAME=		antonym-1.9
CATEGORIES=		security mail
MASTER_SITES=		http://subwiki.honeypot.net/pub/Computing/AntoNym/

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://subwiki.honeypot.net/cgi-bin/view/Computing/AntoNym
COMMENT=		Anonymous nymserver account maintenance tool

DEPENDS+=		p5-Digest-MD5-[0-9]*:../../security/p5-Digest-MD5
DEPENDS+=		pgp-2.*:../../security/pgp2

WRKSRC=			${WRKDIR}/antonym
USE_TOOLS+=		perl:run
REPLACE_PERL=		antonym

PKG_INSTALLATION_TYPES=	overwrite pkgviews
INSTALLATION_DIRS=	bin

do-build: # empty

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/antonym ${PREFIX}/bin/
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/antonym
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/share/examples/antonym/
	${INSTALL_DATA} ${WRKSRC}/replyblocks.dat.example ${PREFIX}/share/examples/antonym/dot.antonym

.include "../../mk/bsd.pkg.mk"
