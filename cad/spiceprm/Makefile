# $NetBSD: Makefile,v 1.15 2006/03/04 21:29:02 jlam Exp $
#

DISTNAME=	spiceprm-0.11
CATEGORIES=	cad
MASTER_SITES=	http://metalab.unc.edu/pub/Linux/apps/circuits/

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Spice preprocessor for parameterized subcircuits

WRKSRC=			${WRKDIR}/spiceprm
NO_BUILD=		YES
USE_TOOLS+=		perl:run
REPLACE_PERL=		spiceprm
INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/spiceprm ${PREFIX}/bin/spiceprm
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/spiceprm
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/share/doc/spiceprm
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/spiceprm
	${INSTALL_DATA} ${WRKSRC}/EXAMPLES ${PREFIX}/share/examples/spiceprm

.include "../../mk/bsd.pkg.mk"
