# $NetBSD: Makefile,v 1.35 2007/10/07 12:59:15 kano Exp $

DISTNAME=	rpm2pkg-2.1.1
PKGREVISION=	2
CATEGORIES=	pkgtools
MASTER_SITES=	# empty
DISTFILES=	# empty

MAINTAINER=	tron@NetBSD.org
HOMEPAGE=	http://www.NetBSD.org/docs/pkgsrc/
COMMENT=	Convert RPM archives to NetBSD packages

CONFLICTS+=	suse-base<=6.4

WRKSRC=		${WRKDIR}
NO_CHECKSUM=	YES

CPPFLAGS+=	${BUILDLINK_CPPFLAGS.bzip2} ${BUILDLINK_CPPFLAGS.rpm} \
		${BUILDLINK_CPPFLAGS.zlib}
LIBS+=		-lrpm -lintl -lz -lbz2

.include "../../mk/bsd.prefs.mk"

.if (${CC} == gcc)
CFLAGS+=	-Wall
.endif

INSTALLATION_DIRS=	${PKGMANDIR}/man8 sbin

do-build:
	${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o ${WRKSRC}/rpm2pkg \
		${FILESDIR}/rpm2pkg.c ${LIBS}

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/rpm2pkg ${PREFIX}/sbin
	${INSTALL_MAN} ${FILESDIR}/rpm2pkg.8 ${PREFIX}/${PKGMANDIR}/man8

.include "../../archivers/bzip2/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../misc/rpm/buildlink3.mk"
.include "../../mk/bdb.buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
