# $NetBSD: Makefile,v 1.17 2007/01/14 14:37:44 obache Exp $
#

DISTNAME=	mysql-connector-odbc-3.51.12
PKGNAME=	${DISTNAME:S/mysql-connector-odbc/myodbc/}
PKGREVISION=	3
CATEGORIES=	databases
MASTER_SITES=	${MASTER_SITE_MYSQL:=MyODBC3/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.mysql.com/
COMMENT=	ODBC driver (server side) for MySQL

GNU_CONFIGURE=	yes
USE_LIBTOOL=	yes
USE_TOOLS+=	gmake

CONFIGURE_ARGS+=	--with-mysql-path=${BUILDLINK_PREFIX.mysql-client}
CONFIGURE_ARGS+=	--disable-gui
CONFIGURE_ARGS+=	--disable-myodbc3i
CONFIGURE_ARGS+=	--without-samples
CONFIGURE_ARGS+=	--disable-test

INSTALLATION_DIRS=	share/doc/myodbc

post-install:
	${INSTALL_DATA} ${WRKSRC}/README* ${PREFIX}/share/doc/myodbc

.include "options.mk"
.include "../../devel/libltdl/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../mk/mysql.buildlink3.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
