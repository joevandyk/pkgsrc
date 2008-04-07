# $NetBSD: buildlink3.mk,v 1.15 2006/09/27 06:02:00 martti Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
VLC_BUILDLINK3_MK:=	${VLC_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	vlc
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nvlc}
BUILDLINK_PACKAGES+=	vlc
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}vlc

.if ${VLC_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.vlc+=	vlc>=0.8.5nb4
BUILDLINK_PKGSRCDIR.vlc?=	../../multimedia/vlc
.endif	# VLC_BUILDLINK3_MK

.include "../../audio/faad2/buildlink3.mk"
.include "../../audio/lame/buildlink3.mk"
.include "../../audio/liba52/buildlink3.mk"
.include "../../audio/libcddb/buildlink3.mk"
.include "../../audio/libid3tag/buildlink3.mk"
.include "../../audio/libmad/buildlink3.mk"
.include "../../audio/libvorbis/buildlink3.mk"
.include "../../converters/fribidi/buildlink3.mk"
.include "../../devel/SDL/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../graphics/SDL_image/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../misc/libcdio/buildlink3.mk"
.include "../../multimedia/ffmpeg/buildlink3.mk"
.include "../../multimedia/libdvdplay/buildlink3.mk"
.include "../../multimedia/libdvdnav/buildlink3.mk"
.include "../../multimedia/libdvdread/buildlink3.mk"
.include "../../multimedia/libmatroska/buildlink3.mk"
.include "../../multimedia/libmpeg2/buildlink3.mk"
.include "../../multimedia/libogg/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/wxGTK/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
