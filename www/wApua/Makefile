# $NetBSD: Makefile,v 1.14 2007/02/22 19:27:24 wiz Exp $
#

DISTNAME=	wApua-0.05.1
CATEGORIES=	www
MASTER_SITES=	http://fsinfo.cs.uni-sb.de/~abe/wApua/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://fsinfo.cs.uni-sb.de/~abe/wApua/
COMMENT=	Web browser for WAP WML

DEPENDS+=	p5-URI>=1.03:../../www/p5-URI
DEPENDS+=	p5-libwww>=5.47:../../www/p5-libwww
DEPENDS+=	p5-Tk>=800.000:../../x11/p5-Tk
DEPENDS+=	p5-HTML-Parser-[0-9]*:../../www/p5-HTML-Parser
DEPENDS+=	p5-MIME-Base64-[0-9]*:../../converters/p5-MIME-Base64
DEPENDS+=	p5-Net-[0-9]*:../../net/p5-Net

PERL5_PACKLIST=		auto/wApua/.packlist

post-install:
	${INSTALL_DATA_DIR} ${PREFIX}/share/doc/wApua
	cd ${WRKSRC}; \
	for i in COPYING README wApua.rc ; do \
		${INSTALL_DATA} $$i ${PREFIX}/share/doc/wApua ; \
	done

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
