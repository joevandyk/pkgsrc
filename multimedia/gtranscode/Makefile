# $NetBSD: Makefile,v 1.3 2006/10/04 21:50:08 wiz Exp $
#

DISTNAME=	gtranscode-v0.3
PKGNAME=	${DISTNAME:S/v//}
PKGREVISION=	1
CATEGORIES=	multimedia
MASTER_SITES=	http://www.fuzzymonkey.net/files/

MAINTAINER=	ccatrian@eml.cc
HOMEPAGE=	http://fuzzymonkey.net/software/gtranscode/
COMMENT=	GTK+ GUI front-end for transcode

DEPENDS+=	transcode-[0-9]*:../../multimedia/transcode

WRKSRC=		${WRKDIR}/gtranscode

INSTALLATION_DIRS=	bin

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/gtranscode ${PREFIX}/bin

.include "../../x11/gtk/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
