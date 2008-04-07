# $NetBSD: options.mk,v 1.6 2007/08/02 21:53:05 dbj Exp $

# Global and legacy options

PKG_OPTIONS_VAR=	PKG_OPTIONS.ffmpeg
PKG_SUPPORTED_OPTIONS=	bktr lame mmx vorbis faac faad a52

.include "../../mk/bsd.options.mk"

.include "../../mk/bsd.prefs.mk"

###
### MMX support
###

.include "../../mk/compiler.mk"

.if !empty(MACHINE_ARCH:Mi386)
.  if !empty(PKG_OPTIONS:Mmmx) && !empty(CC_VERSION:Mgcc*)
CFLAGS+=		-fomit-frame-pointer
.  else
CONFIGURE_ARGS+=	--disable-mmx
.  endif
.else
CONFIGURE_ARGS+=	--disable-mmx
.endif

###
### bktr options
###

.if !empty(PKG_OPTIONS:Mbktr)
post-extract:
	${CP} ${FILESDIR}/grab_bsdbktr.c ${WRKSRC}/libavformat

post-patch:
	${PATCH} -p0 --quiet -d ${WRKSRC} < ${FILESDIR}/bktr.diff
#TODO
#Update the documentation
#	${PATCH} --quiet -d ${WRKSRC} < ${FILESDIR}/ffmpeg.1.diff
.endif

###
### using lame option
###

.if !empty(PKG_OPTIONS:Mlame)
CONFIGURE_ARGS+= --enable-mp3lame
.include "../../audio/lame/buildlink3.mk"
.else
CONFIGURE_ARGS+= --disable-mp3lame
.endif

###
### using vorbis option
###

.if !empty(PKG_OPTIONS:Mvorbis)
CONFIGURE_ARGS+= --enable-vorbis
.include "../../audio/libvorbis/buildlink3.mk"
.else
CONFIGURE_ARGS+= --disable-vorbis
.endif

###
### faad option
###

.if !empty(PKG_OPTIONS:Mfaad)
CONFIGURE_ARGS+=  --enable-faad
.include "../../audio/faad2/buildlink3.mk"
.else
CONFIGURE_ARGS+=  --disable-faad
.endif

###
### faac option
###

.if !empty(PKG_OPTIONS:Mfaac)
CONFIGURE_ARGS+=  --enable-faac
.include "../../audio/faac/buildlink3.mk"
.else
CONFIGURE_ARGS+=  --disable-faac
.endif

###
### a52 option
###

.if !empty(PKG_OPTIONS:Ma52)
CONFIGURE_ARGS+=  --enable-a52
# XXX this pkg currently compiles its own liba52 into libavcodec
#.include "../../audio/liba52/buildlink3.mk"
.else
CONFIGURE_ARGS+=  --disable-a52
.endif
