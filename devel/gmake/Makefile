# $NetBSD: Makefile,v 1.69 2006/10/09 12:52:34 joerg Exp $

DISTNAME=	make-3.81
PKGNAME=	g${DISTNAME}
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GNU:=make/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.gnu.org/software/make/make.html
COMMENT=	GNU version of 'make' utility

PKG_INSTALLATION_TYPES=	overwrite pkgviews
PKG_DESTDIR_SUPPORT=	user-destdir

GNU_CONFIGURE=		yes
TEXINFO_REQD+=		4.0
INFO_FILES=		# PLIST

# NOTE:  the 'test' target requires perl, but since gmake does
# not otherwise require it, perl is not listed as an explicit
# dependency
TEST_TARGET=		check

.include "../../mk/bsd.prefs.mk"

.if defined(GNU_PROGRAM_PREFIX)
CONFIGURE_ARGS+=	--program-prefix=${GNU_PROGRAM_PREFIX:Q}
.endif
PLIST_SUBST+=		GNU_PROGRAM_PREFIX=${GNU_PROGRAM_PREFIX:Q}
BUILD_DEFS+=		GNU_PROGRAM_PREFIX

.if !defined(GNU_PROGRAM_PREFIX) || ${GNU_PROGRAM_PREFIX} != "g"
PLIST_SUBST+=		GMAKE_LINK=""
.else
PLIST_SUBST+=		GMAKE_LINK="@comment "
.endif

PLIST_SRC=		${PKGDIR}/PLIST

GMAKE_LOCALE?=		yes
BUILD_DEFS+=		GMAKE_LOCALE
MAKEFLAGS+=		GMAKE_LOCALE=${GMAKE_LOCALE:Q}
.if !empty(GMAKE_LOCALE:M[yY][eE][sS])
USE_PKGLOCALEDIR=		yes
PLIST_SRC+=			${PKGDIR}/PLIST.locale
USE_TOOLS+=			msgfmt
.  include "../../devel/gettext-lib/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--without-libintl
CONFIGURE_ARGS+=	--without-libiconv
.endif

post-install:
	${CHMOD} g-s ${DESTDIR}${PREFIX}/bin/${GNU_PROGRAM_PREFIX}make
	${CHGRP} ${BINGRP} ${DESTDIR}${PREFIX}/bin/${GNU_PROGRAM_PREFIX}make
.if !defined(GNU_PROGRAM_PREFIX) || ${GNU_PROGRAM_PREFIX} != "g"
	${LN} -sf ${GNU_PROGRAM_PREFIX}make ${DESTDIR}${PREFIX}/bin/gmake
.endif

.include "../../mk/bsd.pkg.mk"
