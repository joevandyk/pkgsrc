# $NetBSD: Makefile,v 1.5 2007/03/17 14:13:23 rillig Exp $
#

DISTNAME=	emech-3.0.2
CATEGORIES=	chat
MASTER_SITES=	http://www.energymech.net/files/

MAINTAINER=	manu@NetBSD.org
HOMEPAGE=	http://www.energymech.net/
COMMENT=	IRC bot written in C

HAS_CONFIGURE=			YES
# The ./configure script is interactive, but selects the default values
# when given no input.
CONFIGURE_ARGS+=		< /dev/null
BUILD_TARGET=			mech
INSTALLATION_DIRS_FROM_PLIST=	yes

post-install:
	${INSTALL_PROGRAM} ${WRKSRC}/energymech ${PREFIX}/bin/mech
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/emech
	${INSTALL_DATA} ${WRKSRC}/sample.conf ${PREFIX}/share/examples/emech/

.include "../../mk/bsd.pkg.mk"
