# $NetBSD: Makefile,v 1.19 2007/10/30 19:31:43 martti Exp $

DISTNAME=		JAlbum${VERSION}
PKGNAME=		jalbum-${VERSION}
#PKGREVISION=		1
CATEGORIES=		www
MASTER_SITES=		http://jalbum.net/download/
DIST_SUBDIR=		${PKGNAME_NOREV}
EXTRACT_SUFX=		.zip

MAINTAINER=		martti@NetBSD.org
HOMEPAGE=		http://jalbum.net/
COMMENT=		Web photo album generator
#LICENSE=		gnu-lgpl-v2

VERSION=		7.1

USE_JAVA=		run
PKG_JVMS_ACCEPTED=	blackdown-jdk13 kaffe sun-jdk13 sun-jdk14 sun-jdk15

WRKSRC=			${WRKDIR}/JAlbum

INSTALLATION_DIRS+=	${PREFIX:Q}/share/jalbum

do-build:
	sed	-e s#@PKG_JAVA_HOME@#${PKG_JAVA_HOME:Q}#g	\
		-e s#@PREFIX@#${PREFIX:Q}#g			\
		< ${FILESDIR:Q}/jalbum > ${WRKDIR:Q}/jalbum

do-install:
	${INSTALL_SCRIPT} ${WRKDIR:Q}/jalbum ${PREFIX:Q}/bin
	(cd ${WRKDIR:Q}/JAlbum && pax -rw * ${PREFIX:Q}/share/jalbum)

.include "../../mk/java-vm.mk"
.include "../../mk/bsd.pkg.mk"
