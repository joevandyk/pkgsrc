# $NetBSD: Makefile,v 1.11 2006/03/04 21:31:06 jlam Exp $
#

DISTNAME=	ZMySQLDA-2.0.8
PKGNAME=	zope25-ZMySQLDA-2.0.8
PKGREVISION=	2
CATEGORIES=	www
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=mysql-python/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://sourceforge.net/projects/mysql-python
COMMENT=	MySQL Database adaptor for Zope

DEPENDS+=	${PYPKGPREFIX}-mysqldb-[0-9]*:../../databases/py-mysqldb

ZOPE_COPYPRODUCT= zope-std-copyproduct-long

.include "../../www/zope25/product.mk"
.include "../../mk/bsd.pkg.mk"
