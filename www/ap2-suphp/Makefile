# $NetBSD: Makefile,v 1.12 2007/11/17 12:04:15 rillig Exp $
#

DISTNAME=		suphp-0.6.0
PKGNAME=		${APACHE_PKG_PREFIX}-${DISTNAME}
PKGREVISION=		3
CATEGORIES=		www
MASTER_SITES=		http://www.suphp.org/download/

MAINTAINER=		rillig@NetBSD.org
HOMEPAGE=		http://www.suphp.org/
COMMENT=		SuEXEC-like wrapper for PHP scripts

USE_TOOLS+=		lex
USE_PKGLOCALEDIR=	yes
GNU_CONFIGURE=		yes
USE_LANGUAGES=		c c++
GCC_REQD+=		3.0	# the C++ code uses the .at() method
CONFIGURE_ARGS+=	APXS=${APXS}
CONFIGURE_ARGS+=	--with-apache-user=${APACHE_USER:Q}
CONFIGURE_ARGS+=	--with-logfile=${VARBASE}/httpd/suphp_log
CONFIGURE_ARGS+=	--sysconfdir=${PKG_SYSCONFDIR:Q}

PKG_USERS_VARS+=	APACHE_USER
BUILD_DEFS+=		VARBASE

EGDIR=			${PREFIX}/share/examples/suphp
CONF_FILES=		${EGDIR}/suphp.conf ${PKG_SYSCONFDIR}/suphp.conf

USE_APR=		yes
PKG_APACHE_ACCEPTED=	apache2 apache22

SUBST_CLASSES+=		suphp
SUBST_STAGE.suphp=	post-configure
SUBST_FILES.suphp=	doc/suphp.conf-example
SUBST_SED.suphp=	-e "s,wwwrun,${APACHE_USER},g"

post-install:
	${INSTALL_DATA_DIR} ${EGDIR:Q}
	${INSTALL_DATA} ${WRKSRC}/doc/suphp.conf-example ${EGDIR}/suphp.conf

.include "../../mk/apache.mk"
.include "../../mk/bsd.pkg.mk"
