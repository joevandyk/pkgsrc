# $NetBSD: Makefile,v 1.11 2007/11/12 00:16:32 wiz Exp $

DISTNAME=	x2x-1.27
PKGREVISION=	2
CATEGORIES=	x11
MASTER_SITES=	ftp://ftp.digital.com/pub/Digital/SRC/x2x/

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	One keyboard and mouse to control multiple X displays

USE_IMAKE=	yes

post-configure:
	(cd ${WRKSRC}; ${LN} -s x2x.1 x2x.man)

.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXtst/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
