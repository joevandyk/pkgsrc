# $NetBSD: Makefile,v 1.25 2007/03/15 05:00:13 dbj Exp $

DISTNAME=	mmix-20060918
CATEGORIES=	emulators devel lang
MASTER_SITES=	http://www-cs-faculty.stanford.edu/~knuth/programs/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www-cs-faculty.stanford.edu/~knuth/mmix.html
COMMENT=	Simulators for Knuth's MMIX RISC architecture

TEX_DEPMETHOD=	build
TEX_ACCEPTED=	teTeX3

WRKSRC=		${WRKDIR}
BUILD_TARGET=	all doc

INSTALLATION_DIRS=	bin

.include "../../mk/tex.buildlink3.mk"

do-install:
	cd ${WRKSRC} && ${INSTALL_PROGRAM} abstime mmix mmixal 		\
		mmmix mmotype ${PREFIX}/bin
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/mmix
	cd ${WRKSRC} && ${INSTALL_DATA} README *.ps 			\
		${PREFIX}/share/doc/mmix
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/mmix
	cd ${WRKSRC} && ${INSTALL_DATA} *.mms *.mmix *.mmconfig 	\
		${PREFIX}/share/examples/mmix

.include "../../mk/bsd.pkg.mk"
