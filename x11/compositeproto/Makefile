# $NetBSD: Makefile,v 1.6 2007/07/25 15:53:10 joerg Exp $
#

DISTNAME=		compositeproto-0.4
CATEGORIES=		x11
MASTER_SITES=		http://xorg.freedesktop.org/releases/individual/proto/

MAINTAINER=		joerg@NetBSD.org
HOMEPAGE=		http://xorg.freedesktop.org/
COMMENT=		Composite extension headers from modular X.org

PKG_DESTDIR_SUPPORT=	user-destdir

CONFLICTS+=		compositeext-[0-9]*

GNU_CONFIGURE=		YES
PKGCONFIG_OVERRIDE+=	${WRKSRC}/compositeproto.pc.in
USE_LANGUAGES=		# none, not even C

.include "../../x11/fixesproto/buildlink3.mk"
.include "../../x11/xproto/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
