# $NetBSD: Makefile,v 1.7 2007/01/07 09:14:09 rillig Exp $
#

DISTNAME=	destroy-20040415
CATEGORIES=	security
MASTER_SITES=	http://www.freebsdhackers.net/destroy/ \
		http://www.impurity.org/mirrors/destroy/

MAINTAINER=	shane@freebsdhackers.net
HOMEPAGE=	http://www.freebsdhackers.net/destroy/
COMMENT=	Program to securely destroy files on the hard disk

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man1

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/destroy ${PREFIX}/bin
	${INSTALL_MAN} ${WRKSRC}/destroy.1 ${PREFIX}/${PKGMANDIR}/man1

.include "../../mk/bsd.pkg.mk"
