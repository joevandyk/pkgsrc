# $NetBSD: Makefile,v 1.6 2007/12/27 16:39:07 adrianp Exp $

DISTNAME=	modsecurity-apache_2.1.1
PKGNAME=	${APACHE_PKG_PREFIX}-${DISTNAME:S/apache_//}
CATEGORIES=	www security
PKGREVISION=	1
MASTER_SITES=	http://www.modsecurity.org/download/

MAINTAINER=	adrianp@NetBSD.org
HOMEPAGE=	http://www.modsecurity.org/
COMMENT=	Intrusion detection and prevention engine for web applications

.include "../../mk/apache.mk"
.include "options.mk"

PKG_APACHE_ACCEPTED=	apache2
BUILD_DIRS=		apache2
EGDIR=			${PREFIX}/share/examples/ap-security
CONF_FILES=		${EGDIR}/modsecurity.conf-minimal \
			${PKG_SYSCONFDIR}/httpd/modsecurity.conf
MESSAGE_SRC+=		${WRKDIR}/.MESSAGE_SRC

BUILDLINK_API_DEPENDS.apache+=	apache>=2.0.59nb2

SUBST_CLASSES=		make
SUBST_STAGE.make=	post-patch
SUBST_FILES.make=	apache2/Makefile
SUBST_SED.make=		-e "s|@PREFIX@|${PREFIX}|g"
SUBST_MESSAGE.make=	Fixing Makefiles.

.if !empty(PKG_OPTIONS:Mxml)
SUBST_SED.make+=	-e "s|@XMLINC@|-I${BUILDLINK_PREFIX.libxml2}/include/libxml2|g"
SUBST_SED.make+=	-e "s|@XMLDEFS@|-DWITH_LIBXML2|g"
.else
SUBST_SED.make+=	-e "s|@XMLINC@||g"
SUBST_SED.make+=	-e "s|@XMLDEFS@||g"
.endif

post-build:
	${CP} ${PKGDIR:Q}/MESSAGE ${WRKDIR:Q}/.MESSAGE_SRC
.if !empty(PKG_OPTIONS:Mxml)
	${CP} ${PKGDIR:Q}/MESSAGE.xml ${WRKDIR:Q}/.MESSAGE_SRC.xml
.endif

post-install:
	${INSTALL_DATA_DIR} ${EGDIR}
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/ap-security

	${INSTALL_DATA} ${WRKSRC}/modsecurity.conf-minimal ${EGDIR}
	cd ${WRKSRC}/doc && ${PAX} -rw . ${PREFIX}/share/doc/ap-security

.include "../../devel/pcre/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
