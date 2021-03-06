# $NetBSD: Makefile,v 1.28 2007/10/07 12:59:14 kano Exp $
#

DISTNAME=		pkg_filecheck-0.4
CATEGORIES=		pkgtools devel
MASTER_SITES=		# empty
DISTFILES=		# empty

MAINTAINER=		dillo@NetBSD.org
#HOMEPAGE=		http://www.NetBSD.org/docs/pkgsrc/
COMMENT=		Check for files not owned by any package

WRKSRC=		${WRKDIR}
USE_TOOLS+=	perl:run
USE_FEATURES=	fts_open

EXTRACT_ONLY=	# empty
NO_CHECKSUM=	yes
NO_CONFIGURE=	yes

FILES_SUBST+=	X11PREFIX=${X11PREFIX:Q}
FILES_SUBST+=	PKG_DBDIR=${PKG_DBDIR:Q}
CONF_FILES=	${PREFIX}/share/examples/pkg_filecheck/pkg_filecheck.conf \
		${PKG_SYSCONFDIR}/pkg_filecheck.conf

INSTALLATION_DIRS=	bin ${PKGMANDIR}/man1 ${PKGMANDIR}/man5

SUBST_CLASSES+=		paths
SUBST_FILES.paths=	builddb.pl builddb.1 pkg_filecheck.conf
SUBST_FILES.paths+=	pkg_filecheck.conf.5 pkg_filecheck.c pkg_filecheck.1
SUBST_SED.paths+=	-e 's,@PREFIX@,${PREFIX},g'
SUBST_SED.paths+=	-e 's,@PERL5@,${PERL5},g'
SUBST_SED.paths+=	-e 's,@X11PREFIX@,${X11PREFIX},g'
SUBST_SED.paths+=	-e 's,@PKG_DBDIR@,${PKG_DBDIR},g'
SUBST_SED.paths+=	-e 's,@PKG_SYSCONFDIR@,${PKG_SYSCONFDIR},g'
SUBST_STAGE.paths=	post-patch

post-extract:
.for f in builddb.pl builddb.1 pkg_filecheck.conf pkg_filecheck.conf.5 \
	pkg_filecheck.c pkg_filecheck.1
	${CP} ${FILESDIR}/${f} ${WRKSRC}/${f}
.endfor

do-build:
	cd ${WRKSRC} \
	    && ${CC} ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} ${BDB_LIBS} \
		-o pkg_filecheck pkg_filecheck.c

do-install:
	${INSTALL_SCRIPT} ${WRKSRC}/builddb.pl ${PREFIX}/bin/builddb
	${INSTALL_PROGRAM} ${WRKSRC}/pkg_filecheck ${PREFIX}/bin/pkg_filecheck
	${INSTALL_MAN} ${WRKSRC}/builddb.1 ${PREFIX}/${PKGMANDIR}/man1
	${INSTALL_MAN} ${WRKSRC}/pkg_filecheck.1 ${PREFIX}/${PKGMANDIR}/man1
	${INSTALL_MAN} ${WRKSRC}/pkg_filecheck.conf.5 ${PREFIX}/${PKGMANDIR}/man5
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/pkg_filecheck
	${INSTALL_DATA} ${WRKSRC}/pkg_filecheck.conf \
		${PREFIX}/share/examples/pkg_filecheck/pkg_filecheck.conf


.include "../../mk/bdb.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
