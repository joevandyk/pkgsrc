# $NetBSD: Makefile,v 1.8 2006/12/27 13:37:38 joerg Exp $
#

DISTNAME=	xgraph-11.3.2-hack.9
PKGNAME=	xgraph-11.3.2.9
PKGREVISION=	2
CATEGORIES=	graphics x11
MASTER_SITES=	http://www.goice.co.jp/member/mo/hack-progs/files/

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Tool to draw a graph on an X11 display

USE_IMAKE=	yes

.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
