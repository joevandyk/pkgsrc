# $NetBSD: Makefile,v 1.39 2007/01/07 09:14:08 rillig Exp $

DISTNAME=	vtun-2.6
PKGREVISION=	6
CATEGORIES=	net
MASTER_SITES=	http://vtun.sourceforge.net/

PATCHFILES=	vtun-26to30.patch
PATCH_SITES+=	${MASTER_SITE_LOCAL}
PATCH_DIST_STRIP=    -p1

MAINTAINER=	cjs@NetBSD.org
HOMEPAGE=	http://vtun.sourceforge.net/
COMMENT=	Virtual Tunnels over TCP/IP networks with traffic shaping

WRKSRC=			${WRKDIR}/vtun

GNU_CONFIGURE=		YES
CONFIGURE_ARGS+=	--localstatedir=${VARBASE:Q}
CONFIGURE_ARGS+=	--sysconfdir=${PKG_SYSCONFDIR:Q}
CONFIGURE_ARGS+=	--with-ssl-headers=${SSLBASE}/include/openssl
CONFIGURE_ARGS+=	--with-ssl-lib=${SSLBASE}/lib
CONFIGURE_ARGS+=	--with-lzo-headers=${BUILDLINK_PREFIX.liblzo}/include
CONFIGURE_ARGS+=	--with-lzo-lib=${BUILDLINK_PREFIX.liblzo}/lib
BUILD_TARGET=		vtund

DOCDIR=			${PREFIX}/share/doc/vtun
EGDIR=			${PREFIX}/share/examples/vtun
LOCKDIR=		/var/run/vtund
LOGDIR=			/var/log/vtund

CONF_FILES_PERMS=	${EGDIR}/vtund.conf ${PKG_SYSCONFDIR}/vtund.conf \
			${ROOT_USER} ${ROOT_GROUP} 0600
OWN_DIRS=		${LOCKDIR} ${LOGDIR}

INSTALLATION_DIRS=	${PKGMANDIR}/man5 ${PKGMANDIR}/man8 sbin

post-build:
	@cd ${WRKSRC}; for file in vtund.8; do				\
		${SED}	-e "s|@PKG_SYSCONFDIR@|${PKG_SYSCONFDIR}|g"	\
			$${file} > $${file}.fixed;			\
		${MV} -f $${file}.fixed $${file};			\
	done
	${SED}	-e "/^[^#]/s|^|#|" -e "s|^$$|#|" ${WRKSRC}/vtund.conf	\
		> ${WRKDIR}/vtund.conf

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/vtund ${PREFIX}/sbin
	${INSTALL_DATA_DIR} ${DOCDIR} ${EGDIR}
	${INSTALL_DATA} ${WRKSRC}/README ${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/README.Crypto ${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/README.Setup ${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/README.Shaper ${DOCDIR}
	${INSTALL_DATA} ${WRKDIR}/vtund.conf ${EGDIR}/vtund.conf
	${INSTALL_MAN} ${WRKSRC}/vtund.conf.5 ${PREFIX}/${PKGMANDIR}/man5
	${INSTALL_MAN} ${WRKSRC}/vtund.8 ${PREFIX}/${PKGMANDIR}/man8
	${RM} -f ${PREFIX}/${PKGMANDIR}/man8/vtun.8
	${LN} -s vtund.8 ${PREFIX}/${PKGMANDIR}/man8/vtun.8

.include "../../archivers/liblzo/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
