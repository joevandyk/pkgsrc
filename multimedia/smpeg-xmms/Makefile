# $NetBSD: Makefile,v 1.9 2006/06/12 16:28:12 wiz Exp $
#

DISTNAME=	smpeg-xmms-0.3.5
PKGREVISION=	8
CATEGORIES=	multimedia
MASTER_SITES=	ftp://ftp.xmms.org/xmms/plugins/smpeg-xmms/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.xmms.org/
COMMENT=	MPEG video plugin using SDL/smpeg as the backend

GNU_CONFIGURE=		YES
USE_TOOLS+=		gmake
USE_LIBTOOL=		YES

.include "../../multimedia/smpeg/buildlink3.mk"
.include "../../devel/glib/buildlink3.mk"
.include "../../x11/gtk/buildlink3.mk"
.include "../../devel/SDL/buildlink3.mk"
.include "../../audio/xmms/buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
