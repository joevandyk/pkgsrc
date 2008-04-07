# $NetBSD: hacks.mk,v 1.1 2007/08/31 15:35:08 minskim Exp $

.if !defined(PNG_HACKS_MK)
PNG_HACKS_MK=	defined

# A workaround for libpng bug #1777158.
.if !empty(MACHINE_PLATFORM:MDarwin-*-i386)
PKG_HACKS+=	darwin-read_only_relocs
LDFLAGS+=	-Wl,-read_only_relocs -Wl,suppress
.endif

.endif		# PNG_HACKS_MK
