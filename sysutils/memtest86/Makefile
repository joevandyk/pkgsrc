# $NetBSD: Makefile,v 1.19 2007/12/30 18:16:16 mlelstv Exp $
#

DISTNAME=		memtest86-3.4
CATEGORIES=		sysutils
MASTER_SITES=		http://www.memtest86.com/

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.memtest86.com/
COMMENT=		Thorough, stand alone memory test for x86 arch

ONLY_FOR_PLATFORM=	NetBSD-*-i386 Linux-*-i386

USE_TOOLS+=		gmake

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/mdec
	${INSTALL_DATA} ${WRKSRC}/memtest ${PREFIX}/mdec
	${INSTALL_DATA} ${WRKSRC}/memtest.bin ${PREFIX}/mdec
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/memtest
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/share/doc/memtest

.include "../../devel/binutils/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
