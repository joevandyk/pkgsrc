# $NetBSD: Makefile,v 1.9 2007/01/07 09:13:49 rillig Exp $
#

DISTNAME=	goofey-3.15
CATEGORIES=	chat
MASTER_SITES=	http://redback.spyda.net/~grant/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	grant@NetBSD.org
HOMEPAGE=	http://www.csse.monash.edu.au/~tym/goofey.html
COMMENT=	Text-based client for goofey, a flexible short message system

NO_CONFIGURE=	yes
LDFLAGS.SunOS+=	-lnsl -lsocket

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man1

do-build:
	cd ${WRKSRC}; ${CC} ${CFLAGS} ${LDFLAGS} -o goofey goofey.c

do-install:
	${INSTALL} ${WRKSRC}/goofey ${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/goofey.1 ${PREFIX}/${PKGMANDIR}/man1

.include "../../mk/bsd.pkg.mk"
