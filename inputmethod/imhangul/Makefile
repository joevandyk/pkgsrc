# $NetBSD: Makefile,v 1.18 2006/07/07 15:49:32 jlam Exp $

DISTNAME=	imhangul-0.9.13
PKGREVISION=	3
CATEGORIES=	inputmethod korean
MASTER_SITES=	http://kldp.net/frs/download.php/2808/
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	minskim@NetBSD.org
HOMEPAGE=	http://imhangul.kldp.net/
COMMENT=	GTK+-2.0 Hangul Input Module

USE_TOOLS+=		pkg-config msgfmt
GNU_CONFIGURE=		YES
USE_LIBTOOL=		YES
SHLIBTOOL_OVERRIDE=	# empty
USE_PKGLOCALEDIR=	YES
GTK2_IMMODULES=		YES

.include "../../x11/gtk2/modules.mk"
.include "../../mk/bsd.pkg.mk"
