# $NetBSD: Makefile,v 1.14 2006/06/15 13:31:29 wiz Exp $
#

DISTNAME=	GutenMark_source_${GVER}
PKGNAME=	GutenMark-${GVER}
PKGREVISION=	2
CATEGORIES=	textproc
MASTER_SITES=	ftp://ftp.sandroid.org/GutenMark/SoftwareSnapshots/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.sandroid.org/GutenMark/
COMMENT=	Automatic, high-quality Gutenberg text formatter to LaTeX or HTML

DEPENDS+=	GutenMark-words-[0-9]*:../../textproc/GutenMark-words

WRKSRC=		${WRKDIR}/GutenMark-source
GVER=		20020714
USE_TOOLS+=	gmake
BUILD_TARGET=	GutenMark

INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/GutenMark ${PREFIX}/bin

.include "../../devel/zlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
