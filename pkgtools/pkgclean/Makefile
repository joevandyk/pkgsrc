# $NetBSD: Makefile,v 1.13 2007/05/18 10:03:31 peter Exp $

DISTNAME=	pkgclean-20051116
CATEGORIES=	pkgtools
MASTER_SITES=	# empty
DISTFILES=	# empty

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Quickly clean up all work directories in pkgsrc

PKG_INSTALLATION_TYPES=	overwrite pkgviews

NO_CHECKSUM=	yes
NO_CONFIGURE=	yes
NO_BUILD=	yes

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man1

do-extract:
	@${CP} -R ${FILESDIR} ${WRKSRC}

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/pkgclean.sh ${PREFIX}/bin/pkgclean
	${INSTALL_MAN} ${WRKSRC}/pkgclean.1 ${PREFIX}/${PKGMANDIR}/man1/pkgclean.1

SUBST_CLASSES+=          path
SUBST_STAGE.path=	post-patch
SUBST_FILES.path=	pkgclean.sh pkgclean.1
SUBST_SED.path+=	-e 's,@SH@,${SH},g'
SUBST_SED.path+=	-e 's,@PKGSRCDIR@,${PKGSRCDIR},g'
SUBST_MESSAGE.path=	Adjusting pkgsrc directory.

.include "../../mk/bsd.pkg.mk"
