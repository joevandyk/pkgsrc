# $NetBSD: Makefile,v 1.35 2006/10/04 21:35:59 wiz Exp $

DISTNAME=		noweb-2.9a
PKGREVISION=		3
CATEGORIES=		devel
MASTER_SITES=		ftp://ftp.cs.virginia.edu/pub/nr/
EXTRACT_SUFX=		.tgz

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.eecs.harvard.edu/~nr/noweb/
COMMENT=		Simple, extensible literate-programming tool

DEPENDS+=		icon>=9.3:../../lang/icon

WRKSRC=			${WRKDIR}/src

.include "../../mk/bsd.prefs.mk"

USE_TOOLS+=	mktemp:run

SUBST_CLASSES+=		mktemp
SUBST_FILES.mktemp+=	awk/totex.nw lib/toascii shell/toroff shell/noroff
SUBST_FILES.mktemp+=	shell/nonu shell/cpif awkname shell/roff.nw
SUBST_FILES.mktemp+=	shell/roff.mm ../contrib/conrado/d2tex
SUBST_FILES.mktemp+=	../contrib/jobling/correct-refs.nw
SUBST_FILES.mktemp+=	../contrib/norman/htmlgif/pstopbm
SUBST_SED.mktemp+=	-e 's,@MKTEMP@,${TOOLS_PATH.mktemp},g'
SUBST_STAGE.mktemp=	post-patch

.if ${OPSYS} != "SunOS"
do-configure:
	cd ${WRKSRC} && ./awkname awk
.endif

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/noweb
	${INSTALL_DATA} ${WRKDIR}/examples/* ${PREFIX}/share/examples/noweb

.include "../../mk/bsd.pkg.mk"
