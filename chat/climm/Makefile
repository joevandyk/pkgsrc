# $NetBSD: Makefile,v 1.2 2007/12/27 14:07:35 joerg Exp $
#

DISTNAME=	climm-0.6.1
PKGREVISION=	1
CATEGORIES=	chat
MASTER_SITES=	http://www.climm.org/source/
EXTRACT_SUFX=	.tgz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.climm.org/source/
COMMENT=	Text-mode ICQ client

USE_TOOLS+=	gmake
GNU_CONFIGURE=	yes
USE_LANGUAGES=	c c++

CONFIGURE_ARGS+=	--disable-tcl --disable-otr --enable-ssl=openssl

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
