# $NetBSD: Makefile,v 1.14 2007/01/13 17:51:06 joerg Exp $
#

DISTNAME=	OroboROX-0.9.8
PKGNAME=	oroborox-0.9.8
PKGREVISION=	1
CATEGORIES=	wm
MASTER_SITES=	http://roxos.sunsite.dk/dev-contrib/guido/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	rxg@NetBSD.org
HOMEPAGE=	http://roxos.sunsite.dk/dev-contrib/guido/
COMMENT=	The lightweight Window Manager for the ROX Desktop

DEPENDS+=	rox-lib>=2.0.2nb2:../../devel/rox-lib

WRKSRC=		${WRKDIR}/OroboROX
DIST_SUBDIR=	rox

PLATFORM=	${OPSYS}-${MACHINE_ARCH}

USE_TOOLS+=		autoconf pkg-config
GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--enable-xft --with-platform=${PLATFORM:Q}

PYTHON_PATCH_SCRIPTS=	Configure/OroboScheme/AppRun
PYTHON_PATCH_SCRIPTS+=	Configure/OroboScheme/AppInfo.py
PYTHON_PATCH_SCRIPTS+=	Configure/OroboScheme/Schemer.py
PYTHON_PATCH_SCRIPTS+=	Configure/Windows/AppRun
PYTHON_PATCH_SCRIPTS+=	Configure/Workspaces/AppRun

INSTALLATION_DIRS=	share/rox/OroboROX

SUBST_CLASSES+=		bin
SUBST_MESSAGE.bin=	Fixing binary path.
SUBST_STAGE.bin=	post-patch
SUBST_FILES.bin=	AppRun
SUBST_SED.bin=		-e 's,BIN="$$APP_DIR/$$PLATFORM,BIN="${PREFIX}/libexec/rox,g'

SUBST_CLASSES+=		path
SUBST_MESSAGE.path=	Fixing hardcoded paths.
SUBST_STAGE.path=	post-patch
SUBST_FILES.path=	AppRun
SUBST_SED.path=		-e 's,/usr/local,${PREFIX},g'

SUBST_CLASSES+=		lib
SUBST_MESSAGE.lib=	Fixing hardcoded paths for ROX-Lib.
SUBST_STAGE.lib=	post-patch
SUBST_FILES.lib=	Configure/Keybindings/findrox.py
SUBST_FILES.lib+=	Configure/Windows/findrox.py
SUBST_FILES.lib+=	Configure/Workspaces/findrox.py
SUBST_FILES.lib+=	Configure/OroboScheme/findrox.py
SUBST_SED.lib=		-e 's,/usr/local/lib,${PREFIX}/share/rox,g'

SUBST_CLASSES+=		py
SUBST_MESSAGE.py=	Replace shell magic by python version.
SUBST_STAGE.py=		post-patch
SUBST_FILES.py=		Configure/Keybindings/AppRun
SUBST_FILES.py+=	Configure/Keybindings/Messages/update-po
SUBST_FILES.py+=	Configure/Windows/Messages/update-po
SUBST_FILES.py+=	Configure/Workspaces/Messages/update-po
SUBST_SED.py=		-e 's,python,python${PYVERSSUFFIX},g'

BUILD_TARGET=		OroboROX
CONFIGURE_DIRS=		src

pre-configure:
	cd ${WRKSRC:Q}/src && autoconf

post-build:
	@${ECHO} "#!/bin/sh" >> ${WRKDIR:Q}/oroborox
	@${ECHO} ${PREFIX:Q}"/share/rox/OroboROX/AppRun \"\$$@\"" >> ${WRKDIR:Q}/oroborox

do-install:
	${INSTALL_PROGRAM} ${WRKSRC:Q}/${PLATFORM:Q}/OroboROX ${PREFIX:Q}/libexec/rox
	cd ${WRKSRC:Q} && ${PAX} -rw	\
		-s ',^\./${PLATFORM}$$,,' -s ',^\./${PLATFORM}/.*,,'	\
		-s ',^\./src$$,,' -s ',^\./src/.*,,'	\
		. ${PREFIX:Q}/share/rox/OroboROX
	${INSTALL_SCRIPT} ${WRKDIR:Q}/oroborox ${PREFIX:Q}/bin

.include "../../devel/libgetopt/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../lang/python/application.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../x11/libXft/buildlink3.mk"
.include "../../x11/libXpm/buildlink3.mk"
.include "../../x11/startup-notification/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
