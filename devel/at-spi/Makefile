# $NetBSD: Makefile,v 1.43 2007/11/07 18:19:19 drochner Exp $
#

DISTNAME=		at-spi-1.20.1
CATEGORIES=		devel
MASTER_SITES=		${MASTER_SITE_GNOME:=sources/at-spi/1.20/}
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.gnome.org/
COMMENT=		Assistive Technology Service Provider Interface

USE_TOOLS+=		gmake intltool msgfmt pkg-config
USE_PKGLOCALEDIR=	yes
USE_LIBTOOL=		yes
GNU_CONFIGURE=		yes

CONFIGURE_ENV+=		PYTHON=true

PKGCONFIG_OVERRIDE+=	cspi-1.0.pc.in
PKGCONFIG_OVERRIDE+=	libloginhelper-1.0.pc.in
PKGCONFIG_OVERRIDE+=	libspi-1.0.pc.in

BUILDLINK_API_DEPENDS.atk+=	atk>=1.18.0

.include "../../devel/atk/buildlink3.mk"
.include "../../devel/gail/buildlink3.mk"
.include "../../devel/libbonobo/buildlink3.mk"
.include "../../devel/popt/buildlink3.mk"
.include "../../net/ORBit2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../x11/libXtst/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
