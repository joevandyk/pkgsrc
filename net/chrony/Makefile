# $NetBSD: Makefile,v 1.22 2006/02/05 23:10:23 joerg Exp $

DISTNAME=	chrony-1.20
PKGREVISION=	3
CATEGORIES=	net
MASTER_SITES=	ftp://chrony.sunsite.dk/projects/chrony/

MAINTAINER=	hannken@NetBSD.org
HOMEPAGE=	http://chrony.sunsite.dk/index.php
COMMENT=	Daemon for maintaining the accuracy of computer clocks

USE_TOOLS+=		gmake
HAS_CONFIGURE=		YES
CONFIGURE_ARGS+=	--prefix=${PREFIX:Q}

EGDIR=			${PREFIX}/share/examples/chrony
EGFILES=		chrony.conf.example chrony.keys.example
RCD_SCRIPTS=		chronyd

MAKE_ENV+=		INSTALL_PROGRAM=${INSTALL_PROGRAM:Q}
MAKE_ENV+=		INSTALL_DATA=${INSTALL_DATA:Q}
MAKE_ENV+=		INSTALL_MAN=${INSTALL_MAN:Q}

SUBST_CLASSES+=		paths
SUBST_FILES.paths=	${EGFILES:S/^/examples\//} chrony.conf.5 chronyd.8
SUBST_SED.paths+=	-e 's,@PREFIX@,${PREFIX},g'
SUBST_SED.paths+=	-e 's,@PKG_SYSCONFDIR@,${PKG_SYSCONFDIR},g'
SUBST_STAGE.paths=	post-patch

post-install:
	${INSTALL_DATA_DIR} ${EGDIR}
	for file in ${EGFILES}; do				\
		${INSTALL_DATA} ${WRKSRC}/examples/$${file}	\
			${EGDIR}/$${file};			\
	done

.include "../../devel/readline/buildlink3.mk"
.include "../../devel/ncurses/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
