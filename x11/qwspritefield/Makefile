# $NetBSD: Makefile,v 1.30 2006/06/04 16:26:56 joerg Exp $

DISTNAME=	QwSpriteField1.6
PKGNAME=	qwspritefield-1.6
PKGREVISION=	4
CATEGORIES=	x11 graphics
MASTER_SITES=	ftp://ftp.troll.no/contrib/

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Efficiently redrawn sprites in the Qt GUI Toolkit

CONFLICTS=	kdesupport<1.1

WRKSRC=		${WRKDIR}/QwSpriteField
USE_LANGUAGES=	c++
USE_TOOLS+=	gmake
USE_LIBTOOL=	yes

QW_INCLUDES=	Pix.h QwCluster.h QwPublicList.h QwSpriteField.h

MAKE_ENV+=	CXX=${CXX:Q} QTDIR=${QT1DIR:Q}

INSTALLATION_DIRS=	lib

do-install:
	@${LIBTOOL} --mode=install ${INSTALL_LIB} ${WRKSRC}/libQwSpriteField.la \
	  ${PREFIX}/lib
	@QT1DIR=${QT1DIR};		\
	${INSTALL_DATA_DIR} $$QT1DIR/include;				\
	for FILE in ${QW_INCLUDES}; do					\
		${INSTALL_DATA} ${WRKSRC}/$$FILE $$QT1DIR/include;	\
	done

.include "../../x11/qt1/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
