# $NetBSD: Makefile,v 1.3 2006/03/04 21:30:34 jlam Exp $

DISTNAME=	hydan-0.13
CATEGORIES=	security
MASTER_SITES=	http://crazyboy.com/hydan/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://crazyboy.com/hydan/
COMMENT=	Steganography tool for covert comms, signing and watermarking

ONLY_FOR_PLATFORM=	NetBSD-*-i386 FreeBSD-*-i386 Linux-*-i386

WRKSRC=		${WRKDIR}/hydan

INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/hydan ${PREFIX}/bin
	cd ${PREFIX}/bin && 						\
		${RM} -f hydan-decode hydan-stats && 			\
		${LN} -s hydan hydan-decode && 				\
		${LN} -s hydan hydan-stats
	${INSTALL_DATA_DIR} ${PREFIX}/share/hydan
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/share/hydan
	${INSTALL_DATA} ${WRKSRC}/README.details ${PREFIX}/share/hydan

.include "../../mk/bsd.pkg.mk"
