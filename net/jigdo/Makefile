# $NetBSD: Makefile,v 1.16 2007/11/17 11:40:59 rillig Exp $

DISTNAME=		jigdo-0.7.3
CATEGORIES=		net
MASTER_SITES=		http://atterer.net/jigdo/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://atterer.net/jigdo/
COMMENT=		Tool to ease downloading of large files from the Internet

USE_TOOLS+=		pkg-config
USE_LANGUAGES=		c c++
GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--without-libdb
BROKEN_GETTEXT_DETECTION=	yes

#.include "../../databases/db3/buildlink3.mk"
.include "../../www/curl/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../www/libwww/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
