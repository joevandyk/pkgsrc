# $NetBSD: Makefile,v 1.3 2005/11/05 20:12:36 minskim Exp $

DISTNAME=	ruby-doc-stdlib-0.10.1
CATEGORIES=	lang ruby
MASTER_SITES=	http://www.ruby-doc.org/downloads/stdlib/
EXTRACT_SUFX=	.tgz

MAINTAINER=	minskim@NetBSD.org
HOMEPAGE=	http://www.ruby-doc.org/
COMMENT=	Ruby Standard Library Documentation

NO_CONFIGURE=	yes
NO_BUILD=	yes

PLIST_SRC=	${WRKDIR}/.PLIST_SRC
DOCDIR=		share/doc/${PKGBASE}

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/${DOCDIR}
	${CP} -R ${WRKSRC}/stdlib/* ${PREFIX}/${DOCDIR}
	${CHOWN} -R ${SHAREOWN}:${SHAREGRP} ${PREFIX}/${DOCDIR}
	${FIND} ${PREFIX}/${DOCDIR} -type d -print |			\
		${XARGS} ${CHMOD} ${PKGDIRMODE}
	${FIND} ${PREFIX}/${DOCDIR} -type f -print |			\
		${XARGS} ${CHMOD} ${SHAREMODE}
	${CAT} ${PKGDIR}/PLIST.pre >${PLIST_SRC}
	cd ${PREFIX} &&	${FIND} ${DOCDIR} -type f -print >> ${PLIST_SRC}
	cd ${PREFIX} && ${FIND} -d ${DOCDIR} -type d -print |		\
		${SED} -e "s/^/@dirrm /" >>${PLIST_SRC}

.include "../../mk/bsd.pkg.mk"
