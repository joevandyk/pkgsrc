# $NetBSD: Makefile,v 1.34 2006/10/04 20:52:12 wiz Exp $

DISTNAME=	psiconv-0.9.7
CATEGORIES=	converters
MASTER_SITES=	http://www.frodol.dds.nl/psiconv/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.frodol.dds.nl/psiconv/
COMMENT=	PSION 5 file format data conversion utilities

USE_LIBTOOL=		yes
GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--without-imagemagick
CONFIGURE_ARGS+=	--with-etcdir=${EGDIR:Q}

EGDIR=		${PREFIX}/share/examples/psiconv
CONF_FILES+=	${EGDIR}/psiconv.conf ${PKG_SYSCONFDIR}/psiconv.conf
CONF_FILES+=	${EGDIR}/psiconv.conf.eg ${PKG_SYSCONFDIR}/psiconv.conf.eg

.include "../../mk/bsd.pkg.mk"
