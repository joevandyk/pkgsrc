# $NetBSD: Makefile,v 1.12 2006/09/03 00:56:30 wiz Exp $
#

DISTNAME=	pkgdep-1.0
CATEGORIES=	pkgtools
MASTER_SITES=	# empty
DISTFILES=	# empty

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Script for displaying dependence information on software packages

WRKSRC=		${WRKDIR}
USE_TOOLS+=	perl:run

EXTRACT_ONLY=	# empty
NO_CHECKSUM=	yes
NO_CONFIGURE=	yes

INSTALLATION_DIRS=	bin

do-build:
	${CP} ${FILESDIR}/pkgdep.pl ${WRKDIR}/pkgdep
#	${SED} -e 's|/usr/pkgsrc|${PKGSRCDIR}|' \
#		${FILESDIR}/pkgdep.pl > ${WRKDIR}/pkgdep

do-install:
	${INSTALL_SCRIPT} ${WRKDIR}/pkgdep ${PREFIX}/bin

.include "../../mk/bsd.pkg.mk"
