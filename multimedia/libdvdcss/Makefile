# $NetBSD: Makefile,v 1.17 2007/07/20 11:53:27 tnn Exp $
#
# In order to ensure compliance with U.S. and international law, please
# do not modify this file to provide pointers to the source or homepage
# for this software or submit any PRs telling us the contents of the
# HOMEPAGE or MASTER_SITES definitions in this Makefile.

DISTNAME=	libdvdcss-1.2.9
CATEGORIES=	multimedia
MASTER_SITES=	${LIBDVDCSS_MASTER_SITES}/${DISTNAME:S/libdvdcss-//}/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	recht@NetBSD.org
HOMEPAGE=	${LIBDVDCSS_HOMEPAGE}
COMMENT=	Simple library designed for accessing DVDs

PKG_DESTDIR_SUPPORT=	user-destdir

RESTRICTED=	Legal problems due to CSS code

# no source because of the CSS source code in it
NO_SRC_ON_FTP=		${RESTRICTED}
NO_BIN_ON_FTP=		${RESTRICTED}
NO_SRC_ON_CDROM=	${RESTRICTED}
NO_BIN_ON_CDROM=	${RESTRICTED}

GNU_CONFIGURE=		YES
USE_LIBTOOL=		YES

.include "../../mk/bsd.prefs.mk"

.if !exists(${DISTDIR}/${DISTNAME}${EXTRACT_SUFX}) && !defined(LIBDVDCSS_MASTER_SITES)
PKG_FAIL_REASON+=	"Please define LIBDVDCSS_MASTER_SITES in mk.conf."
PKG_FAIL_REASON+=	"Alternatively you may download '${DISTNAME}${EXTRACT_SUFX}' manually"
PKG_FAIL_REASON+=	"to ${DISTDIR}."
.endif

.include "../../mk/bsd.pkg.mk"
