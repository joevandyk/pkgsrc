# $NetBSD: Makefile,v 1.12 2005/12/29 06:22:07 jlam Exp $
#

DISTNAME=	pnm2ppa-1.12
CATEGORIES=	print converters graphics
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=pnm2ppa/}

MAINTAINER=	kei@NetBSD.org
HOMEPAGE=	http://pnm2ppa.sourceforge.net/
COMMENT=	Filter to convert PNM file to PPA used by some HP DJ printer

CONF_FILES=	${PREFIX}/share/examples/pnm2ppa/pnm2ppa.conf \
		${PKG_SYSCONFDIR}/pnm2ppa.conf

post-build:
	for f in				\
	${WRKSRC}/docs/en/CALIBRATION.txt	\
	${WRKSRC}/docs/en/COLOR.txt		\
	${WRKSRC}/docs/en/pnm2ppa.1 ;		\
	do					\
		${CP} $$f $$f.orig ;		\
		${SED} 's|/etc/pnm2ppa|${PKG_SYSCONFDIR}/pnm2ppa|g'	\
			$$f.orig > $$f ;	\
	done

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/pnm2ppa
	cd ${WRKSRC} &&	\
	${INSTALL_DATA} docs/en/CALIBRATION.txt	docs/en/COLOR.txt	\
		${PREFIX}/share/doc/pnm2ppa

.include "../../devel/libgetopt/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
