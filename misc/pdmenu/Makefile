# $NetBSD: Makefile,v 1.25 2007/02/22 19:01:23 wiz Exp $
#

DISTNAME=	pdmenu_1.2.65
PKGNAME=	${DISTNAME:S/_/-/}
PKGREVISION=	3
CATEGORIES=	misc
MASTER_SITES=	http://www.kitenet.net/programs/pdmenu/

MAINTAINER=	zuntum@NetBSD.org
HOMEPAGE=	http://www.kitenet.net/~joey/code/pdmenu.html
COMMENT=	Simple console menu program

WRKSRC=		${WRKDIR}/pdmenu
GNU_CONFIGURE=	YES
USE_TOOLS+=	gmake perl:run

REPLACE_PERL=	examples/showdir.pl


CONFIGURE_ENV+=	SLANG_LIB_LOC=${BUILDLINK_PREFIX.libslang:Q}/lib
CONFIGURE_ENV+=	SLANG_H_LOC=${BUILDLINK_PREFIX.libslang:Q}/include/slang.h

pre-install:
	${SED} "s,.B /etc/pdmenurc,.B ${PREFIX}/etc/pdmenurc,g"		\
		${WRKSRC}/doc/pdmenurc.man > ${WRKSRC}/doc/pdmenurc.man.done
	${MV} ${WRKSRC}/doc/pdmenurc.man.done ${WRKSRC}/doc/pdmenurc.man
	${INSTALL_DATA_DIR} ${PREFIX}/lib/pdmenu

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/pdmenu
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/pdmenu
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/pdmenu/newbie
	cd ${WRKSRC}/doc && ${INSTALL_DATA} ANNOUNCE BUGS TODO \
		${PREFIX}/share/doc/pdmenu
	cd ${WRKSRC}/examples && ${INSTALL_DATA} README ba.lpd pdmenurc \
		pdmenurc.complex pdmenurc.monitor showdir.pl \
		${PREFIX}/share/examples/pdmenu
	cd ${WRKSRC}/examples/newbie && ${INSTALL_DATA} modem-check \
		pdmenurc.newbie	rpm-info-on-command \
		${PREFIX}/share/examples/pdmenu/newbie

.include "../../devel/libslang/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
