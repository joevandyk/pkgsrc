# $NetBSD: Makefile,v 1.2 2007/02/22 19:30:03 wiz Exp $
#

DISTNAME=		scummvm-tools-0.9.0
CATEGORIES=		games
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=scummvm/}
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		dillo@NetBSD.org
HOMEPAGE=		http://scummvm.sourceforge.net/
COMMENT=		Conversion and compression tools for ScummVM

WRKSRC=		${WRKDIR}/tools-0.9.0
USE_LANGUAGES=	c c++
USE_TOOLS+=	gmake

DEPENDS+=	flac-[0-9]*:../../audio/flac
DEPENDS+=	lame-[0-9]*:../../audio/lame
DEPENDS+=	vorbis-tools-[0-9]*:../../audio/vorbis-tools

do-install:
	for f in compress_kyra compress_queen compress_saga \
        	compress_scumm_san compress_scumm_sou compress_scumm_bun \
        	compress_simon compress_sword1 compress_sword2 dekyra \
        	descumm desword2 encode_dxa extract_kyra extract_loom_tg16 \
        	extract_mm_c64 extract_mm_nes extract_scumm_mac \
        	extract_simon1_amiga extract_zak_c64; \
	do \
		${INSTALL_PROGRAM} ${WRKSRC}/$$f ${LOCALBASE}/bin; \
	done
	${INSTALL_DATA_DIR} ${LOCALBASE}/share/doc/scummvm-tools
	${INSTALL_DATA} ${WRKSRC}/README ${LOCALBASE}/share/doc/scummvm-tools

.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
