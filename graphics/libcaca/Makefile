# $NetBSD: Makefile,v 1.14 2006/10/14 08:03:57 wiz Exp $
#

DISTNAME=	libcaca-0.9
PKGREVISION=	1
CATEGORIES=	graphics
MASTER_SITES=	http://libcaca.zoy.org/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://libcaca.zoy.org/
COMMENT=	Graphics library that outputs text instead of pixels, in colour

USE_LIBTOOL=		yes
USE_PKGLOCALEDIR=	yes
GNU_CONFIGURE=		yes
INCOMPAT_CURSES=	NetBSD-1.5*-* NetBSD-1.6[-_.]*-* NetBSD-1.6[A-Q]-*

.include "options.mk"

CONFIGURE_ARGS+=	--disable-doc

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Linux"
LDFLAGS+=	-ldl
.endif

.include "../../mk/bsd.pkg.mk"
