# $NetBSD: Makefile,v 1.23 2007/03/21 19:24:11 jwise Exp $

DISTNAME=	spfc-0.2.0
PKGREVISION=	1
CATEGORIES=	www java
MASTER_SITES=	http://java.apache.org/spfc/dist/

MAINTAINER=	jwise@NetBSD.org
HOMEPAGE=	http://java.apache.org/
COMMENT=	Apache.org's Server Page Foundation Classes

BROKEN=		this package is unmaintained and supplanted by newer JSP releases.  if you use this, speak now.
BROKEN_IN=	pkgsrc-2005Q4 pkgsrc-2006Q1 pkgsrc-2006Q4

# yes, this needs _exactly_ version 2.0
DEPENDS+=	jsdk-2.0nb1:../../www/jsdk20

.include "../../mk/bsd.prefs.mk"

WRKSRC=		${WRKDIR}/spfc-0.2.0/src/
USE_TOOLS+=	gmake
NO_CONFIGURE=	yes
MAKE_ENV+=	CLASSPATH=${CLASSPATH}:${PREFIX}/lib/jsdk.jar

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/lib/java
	${INSTALL_DATA} ${WRKSRC}/../bin/spfc.jar ${PREFIX}/lib/java
	${INSTALL_PROGRAM_DIR} ${PREFIX}/share/doc/java/spfc
	cd ${WRKSRC}/../docs && ${PAX} -rw -pp . ${PREFIX}/share/doc/java/spfc

.include "../../mk/java-vm.mk"
.include "../../mk/bsd.pkg.mk"

# This must be after the include of bsd.pkg.mk
CLASSPATH:=${CLASSPATH}:${PREFIX}/lib/java/jsdk.jar:.
