# $NetBSD: Makefile,v 1.12 2007/03/21 19:44:11 jwise Exp $

DISTNAME=	lwm-1.2.1
PKGREVISION=	1
CATEGORIES=	x11 wm
MASTER_SITES=	http://www.jfc.org.uk/files/lwm/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.jfc.org.uk/software/lwm.html
COMMENT=	Lightweight Window Manager

USE_IMAKE=	YES

.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../x11/xextproto/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
