# $NetBSD: Makefile,v 1.15 2006/03/04 21:29:26 jlam Exp $
#

DISTNAME=		physfs-1.0.1
CATEGORIES=		devel
MASTER_SITES=		http://offload1.icculus.org/physfs/downloads/

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.icculus.org/physfs/
COMMENT=		Library providing abstract access to various archives

USE_LIBTOOL=		yes
GNU_CONFIGURE=		yes
USE_LANGUAGES=		c c++
CONFIGURE_ARGS+=	--enable-pthreads
PTHREAD_AUTO_VARS=	yes

.include "../../devel/readline/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"

.include "../../mk/curses.buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
