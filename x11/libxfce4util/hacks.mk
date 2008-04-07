# $NetBSD: hacks.mk,v 1.1 2006/02/18 20:43:00 schwarz Exp $

.if !defined(LIBXFCE4UTIL_HACKS_MK)
LIBXFCE4UTIL_HACKS_MK=	# defined

### [Sat Feb  4 09:07:25 CET 2006: schwarz]
### SGI ido compiler does not handle (...) in defines
###
.if ${PKGSRC_COMPILER} == "ido"
PKG_HACKS+=		no-dots-in-defines
SUBST_CLASSES+=		dots
SUBST_STAGE.dots=	post-patch
SUBST_FILES.dots=	libxfce4util/xfce-miscutils.h libxfce4util/debug.h
SUBST_SED.dots=		-e 's,(\.\.\.),(x),g'
.endif

.endif
