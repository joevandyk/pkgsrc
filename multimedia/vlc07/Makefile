# $NetBSD: Makefile,v 1.11 2007/09/29 19:44:05 drochner Exp $
#

DISTNAME=		vlc-${VLC_VER}
PKGREVISION=		18
CATEGORIES=		multimedia
MASTER_SITES=		http://download.videolan.org/pub/videolan/vlc/${VLC_VER}/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.videolan.org/
COMMENT=		VideoLAN Client

USE_LANGUAGES=		c c++
USE_TOOLS+=		gmake pkg-config
USE_PKGLOCALEDIR=	yes
GNU_CONFIGURE=		yes
PTHREAD_OPTS+=		require

VLC_VER=		0.7.2

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "NetBSD"
CONFIGURE_ARGS+=	--disable-vcd
.endif
BUILDLINK_API_DEPENDS.vcdimager+=	vcdimager>=0.7.20nb1
BUILDLINK_API_DEPENDS.ffmpeg+=	ffmpeg>=0.4.8nb1 # Postprocess fix

CONFIGURE_ARGS+=	--disable-skins2
CONFIGURE_ARGS+=	--disable-speex # needs unstable 1.1.x branch

CONFIGURE_ARGS+=	--enable-dvb
CONFIGURE_ARGS+=	--enable-flac
CONFIGURE_ARGS+=	--disable-gtk
CONFIGURE_ARGS+=	--with-ffmpeg-tree=${BUILDLINK_PREFIX.ffmpeg}/lib

BUILD_DEFS+=		WITH_DVDCSS

.if defined(WITH_DVDCSS) && !empty(WITH_DVDCSS:M[Yy][Ee][Ss])
CONFIGURE_ARGS+=	--with-dvdcss=${BUILDLINK_PREFIX.libdvdcss}
.include "../../multimedia/libdvdcss/buildlink3.mk"
PLIST_SUBST+=		DVDCSS=
.else
CONFIGURE_ARGS+=	--disable-dvd
PLIST_SUBST+=		DVDCSS="@comment "
.endif

.if ${X11_TYPE} == "modular"
CONFIGURE_ARGS+=	x_libraries=${PREFIX}/lib
.endif

.if ${MACHINE_ARCH} == i386
.include "../../mk/compiler.mk"
.if !empty(CC_VERSION:Mgcc-3.3.*)
# XXX this makes that -mcpu is used, default is patched to -mtune
CONFIGURE_ARGS+=	--with-tuning=pentiumpro
.endif
.endif

INSTALLATION_DIRS=	share/vlc/skins/default share/vlc/skins2/default \
			share/vlc/skins2/fonts share/vlc/http/admin \
			share/vlc/http/vlm

pre-install:
	${INSTALL_DATA} ${WRKSRC}/doc/vlc.1 ${PREFIX}/${PKGMANDIR}/man1
	${INSTALL_DATA} ${WRKSRC}/doc/vlc-config.1 ${PREFIX}/${PKGMANDIR}/man1

ORIGFNT=		/usr/share/fonts/truetype/freefont/FreeSerifBold.ttf
DEFAULT_FONT?=		${X11BASE}/lib/X11/fonts/TTF/luximb.ttf

SUBST_CLASSES+=		oss fnt libav
SUBST_STAGE.oss=	post-patch
SUBST_SED.oss=		-e "s,/dev/dsp,${DEVOSSAUDIO},g"
SUBST_FILES.oss+=	modules/access/v4l/v4l.c
SUBST_FILES.oss+=	modules/audio_output/oss.c
SUBST_FILES.oss+=	modules/gui/pda/pda_interface.c
SUBST_FILES.oss+=	modules/gui/pda/pda.glade
SUBST_MESSAGE.oss=	Fixing hardcoded audio device.
SUBST_STAGE.fnt=	post-patch
SUBST_SED.fnt=		-e "s,${ORIGFNT},${DEFAULT_FONT},"
SUBST_FILES.fnt=	modules/misc/freetype.c
SUBST_MESSAGE.fnt=	Fixing hardcoded paths.
SUBST_STAGE.libav=	post-patch
SUBST_FILES.libav=	configure
SUBST_SED.libav=	-e "s,libavcodec/libavcodec.a,libavcodec.a,g"

BUILDLINK_FNAME_TRANSFORM.ffmpeg+=	-e "s,include/ffmpeg,include/,g"

.include "../../audio/flac/buildlink3.mk"
.include "../../audio/lame/buildlink3.mk"
.include "../../audio/liba52/buildlink3.mk"
.include "../../audio/libcddb/buildlink3.mk"
.include "../../audio/libid3tag/buildlink3.mk"
.include "../../audio/libmad/buildlink3.mk"
.include "../../audio/libvorbis/buildlink3.mk"
.include "../../converters/fribidi/buildlink3.mk"
.include "../../devel/SDL/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../misc/libcdio/buildlink3.mk"
.include "../../multimedia/ffmpeg/buildlink3.mk"
.include "../../multimedia/libdvdplay/buildlink3.mk"
.include "../../multimedia/libdvdnav/buildlink3.mk"
.include "../../multimedia/libdvbpsi/buildlink3.mk"
.include "../../multimedia/libdvdread/buildlink3.mk"
.include "../../multimedia/libmatroska/buildlink3.mk"
.include "../../multimedia/libmpeg2/buildlink3.mk"
.include "../../multimedia/libogg/buildlink3.mk"
.include "../../net/openslp/buildlink3.mk"
.include "../../sysutils/vcdimager-devel/buildlink3.mk"
.include "../../x11/libXv/buildlink3.mk"
.include "../../x11/wxGTK/buildlink3.mk"

.include "../../mk/oss.buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
