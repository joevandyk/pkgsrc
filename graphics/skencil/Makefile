# $NetBSD: Makefile,v 1.11 2007/02/22 19:26:36 wiz Exp $
#

DISTNAME=	skencil-0.6.17
PKGREVISION=	2
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=sketch/}

MAINTAINER=	uebayasi@NetBSD.org
HOMEPAGE=	http://sketch.sourceforge.net/
COMMENT=	Interactive drawing program

PYTHON_PATCH_SCRIPTS= sk2ppm.py sk2ps.py skconvert.py skencil.py skshow.py
SK_CONF_ARGS=	--imaging-include=${BUILDLINK_PREFIX.pyimaging}/${PYINC}/PIL
SK_TKFLAGS=	-L${BUILDLINK_PREFIX.tk}/lib -R${BUILDLINK_PREFIX.tk}/lib -ltk -ltcl
SK_TKFLAGS+=	-R${X11BASE}/lib
SK_CONF_ARGS+=	--tk-flags=${SK_TKFLAGS:Q}

do-configure:
	cd ${WRKSRC} && ${SETENV} ${CONFIGURE_ENV} \
	    ${PYTHONBIN} setup.py configure ${SK_CONF_ARGS}

do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${PYTHONBIN} setup.py build

do-install:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${PYTHONBIN} setup.py install \
		--prefix=${PREFIX}

SKETCHDOCDIR=	${PREFIX}/share/doc/skencil
SKETCHDOCS=	BUGS Doc NEWS PROJECTS README TODO
SKETCHEXDIR=	${PREFIX}/share/examples/skencil

post-install:
	${INSTALL_DATA_DIR} ${SKETCHDOCDIR}
	cd ${WRKSRC} && ${PAX} -rwpm -v ${SKETCHDOCS} ${SKETCHDOCDIR}
	${RM} ${SKETCHDOCDIR}/Doc/fonts.alias
	${RM} ${SKETCHDOCDIR}/Doc/fonts.scale
	${INSTALL_DATA_DIR} ${SKETCHEXDIR}
	cd ${WRKSRC}/Examples && ${PAX} -rwpm -v . ${SKETCHEXDIR}

.include "../../lang/python/application.mk"
.include "../../graphics/py-imaging/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../x11/py-Tk/buildlink3.mk"
.include "../../x11/xextproto/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
