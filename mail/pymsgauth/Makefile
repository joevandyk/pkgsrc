# $NetBSD: Makefile,v 1.6 2006/03/14 01:14:30 jlam Exp $
#

DISTNAME=		pymsgauth-2.1.0
PKGREVISION=		1
CATEGORIES=		mail
MASTER_SITES=		${HOMEPAGE}

MAINTAINER=		schmonz@NetBSD.org
HOMEPAGE=		http://pyropus.ca/software/pymsgauth/
COMMENT=		Automatically process qsecretary confirmation requests

PYMSGAUTH_PROGRAMS=	pymsgauth-*
DOCS=			BUGS CHANGELOG COPYING pymsgauth.txt
HTMLDOCS=		pymsgauth.html
EXAMPLES=		pymsgauthrc-example

SHAREDIR=		share/pymsgauth
DOCDIR=			share/doc/pymsgauth
HTMLDOCDIR=		share/doc/html/pymsgauth
EGDIR=			share/examples/pymsgauth

NO_BUILD=		yes
PYTHON_PATCH_SCRIPTS=	${PYMSGAUTH_PROGRAMS} *.py

FILES_SUBST+=		SHAREDIR=${SHAREDIR:Q}

INSTALLATION_DIRS=	${SHAREDIR} ${DOCDIR} ${HTMLDOCDIR} ${EGDIR} bin

do-install:
	for f in ${PYTHON_PATCH_SCRIPTS}; do \
		${INSTALL_SCRIPT} ${WRKSRC}/$${f} ${PREFIX}/${SHAREDIR}; \
	done

	for f in ${DOCS}; do \
		${INSTALL_DATA} ${WRKSRC}/$${f} ${PREFIX}/${DOCDIR}; \
	done

	for f in ${HTMLDOCS}; do \
		${INSTALL_DATA} ${WRKSRC}/$${f} ${PREFIX}/${HTMLDOCDIR}; \
	done

	for f in ${EXAMPLES}; do \
		${INSTALL_DATA} ${WRKSRC}/$${f} ${PREFIX}/${EGDIR}; \
	done

.include "../../lang/python/application.mk"
.include "../../mk/bsd.pkg.mk"
