# $NetBSD: Makefile,v 1.16 2007/09/21 13:04:08 wiz Exp $

DISTNAME=	ogle_gui-0.9.2
PKGREVISION=	8
CATEGORIES=	multimedia
MASTER_SITES=	http://www.dtek.chalmers.se/groups/dvd/dist/

MAINTAINER=	veego@NetBSD.org
HOMEPAGE=	http://www.dtek.chalmers.se/groups/dvd/
COMMENT=	GUI for the Ogle DVD player

USE_PKGLOCALEDIR=	yes
USE_TOOLS+=		gmake pkg-config
USE_LIBTOOL=		yes

GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--bindir=${PREFIX}/lib/ogle
CONFIGURE_ARGS+=	--enable-gtk2

GCC_REQD+=		2.95.3

.include "../../devel/libglade/buildlink3.mk"
.include "../../multimedia/ogle/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
