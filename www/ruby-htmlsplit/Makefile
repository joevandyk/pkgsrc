# $NetBSD: Makefile,v 1.12 2006/02/05 23:11:28 joerg Exp $

DISTNAME=	htmlsplit102
PKGNAME=	${RUBY_PKGPREFIX}-htmlsplit-1.0.2
PKGREVISION=	2
CATEGORIES=	www ruby
MASTER_SITES=	http://www.moonwolf.com/ruby/archive/
EXTRACT_SUFX=	.zip

MAINTAINER=	taca@NetBSD.org
HOMEPAGE=	http://www.moonwolf.com/ruby/htmlsplit.html
COMMENT=	Ruby HTML split/join library

WRKSRC=		${WRKDIR}
NO_CONFIGURE=	yes
NO_BUILD=	yes

do-install:
	${INSTALL_DATA_DIR} ${RUBY_SITELIBDIR}
	${INSTALL_DATA} ${WRKSRC}/htmlsplit.rb ${RUBY_SITELIBDIR}
	${INSTALL_DATA_DIR} ${RUBY_EXAMPLESDIR}/htmlsplit
	${INSTALL_DATA} ${WRKSRC}/splittest.rb ${RUBY_EXAMPLESDIR}/htmlsplit

.include "../../lang/ruby/modules.mk"
.include "../../mk/bsd.pkg.mk"
