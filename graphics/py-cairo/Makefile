# $NetBSD: Makefile,v 1.8 2007/08/23 20:50:52 heinz Exp $
#

DISTNAME=		pycairo-1.4.0
PKGNAME=		${PYPKGPREFIX}-cairo-1.4.0
CATEGORIES=		graphics
MASTER_SITES=		http://cairographics.org/releases/

MAINTAINER=		leuzi@trash.net
HOMEPAGE=		http://cairographics.org/pycairo/
COMMENT=		Python bindings for cairo

PKG_DESTDIR_SUPPORT=	user-destdir

USE_PKGLOCALEDIR=	yes
USE_LIBTOOL=		yes
USE_TOOLS+=		pkg-config
GNU_CONFIGURE=		yes
CONFIGURE_ENV+=		PYTHON=${PYTHONBIN:Q}

PKGCONFIG_OVERRIDE+=	pycairo.pc.in
PYTHON_VERSIONS_ACCEPTED= 24 23
PY_PATCHPLIST=		yes

.include "../../mk/compiler.mk"

.if !empty(CC_VERSION:Mgcc-2*)
BUILDLINK_TRANSFORM+=	rm:-std=c99
.endif

BUILDLINK_API_DEPENDS.cairo+=	cairo>=1.4.0

.include "../../lang/python/extension.mk"
.include "../../math/py-Numeric/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
