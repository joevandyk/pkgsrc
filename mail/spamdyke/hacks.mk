# $NetBSD: hacks.mk,v 1.1 2007/04/11 14:50:37 schmonz Exp $

.include "../../mk/bsd.prefs.mk"

# Fix build on OS X with BIND9 system resolver
.if ${OPSYS} == "Darwin"
PKG_HACKS+=		macosx-bind9-bind8compat
CFLAGS+=		-DBIND_8_COMPAT=1
.endif
