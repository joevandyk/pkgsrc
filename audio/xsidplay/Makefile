# $NetBSD: Makefile,v 1.40 2007/01/11 09:41:04 joerg Exp $
#

DISTNAME=	xsidplay-1.6.5.1a
PKGREVISION=	4
CATEGORIES=	audio x11
MASTER_SITES=	http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/packages/
EXTRACT_SUFX=	.tgz

MAINTAINER=	pooka@NetBSD.org
HOMEPAGE=	http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/
COMMENT=	Commodore 64 music player and SID chip emulator for X11

GNU_CONFIGURE=		yes
USE_LANGUAGES=		c c++
USE_LIBTOOL=		yes
USE_TOOLS+=		gmake
MAKE_ENV+=		MACHINE_ARCH=${MACHINE_ARCH:Q}

CONFIGURE_ARGS+=	--with-qt-dir=${QTDIR:Q}
CONFIGURE_ENV+=		DISABLE_ESD_TEST=yes
CONFIGURE_ENV+=		DISABLE_ARTSD_TEST=yes

INSTALLATION_DIRS=	bin

pre-configure:
	rm ${WRKSRC}/scripts/ltmain.sh && ${LN} -s ${PREFIX}/share/libtool/ltmain.sh ${WRKSRC}/scripts/ltmain.sh

do-install:
	@${INSTALL_PROGRAM} ${WRKSRC}/src/xsidplay ${PREFIX}/bin

BUILDLINK_DEPMETHOD.libXt?=	build

.include "../../audio/libsidplay/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.include "../../x11/qt3-libs/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
