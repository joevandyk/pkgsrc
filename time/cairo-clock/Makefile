# $NetBSD: Makefile,v 1.8 2007/10/01 03:21:03 joerg Exp $
#

DISTNAME=	cairo-clock_0.3.3-1
PKGNAME=	cairo-clock-0.3.3
PKGREVISION=	3
CATEGORIES=	time
MASTER_SITES=	http://macslow.thepimp.net/projects/cairo-clock/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://macslow.thepimp.net/?page_id=23
COMMENT=	Analog clock drawn with vector-graphics

WRKSRC=		${WRKDIR}/cairo-clock-0.3.3
GNU_CONFIGURE=	yes
USE_LIBTOOL=	yes
USE_TOOLS+=	intltool pkg-config msgfmt
USE_DIRS+=	xdg-1.1

.include "../../x11/gtk2/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../graphics/librsvg/buildlink3.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
