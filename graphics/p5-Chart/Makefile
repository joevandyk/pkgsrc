# $NetBSD: Makefile,v 1.7 2007/05/16 20:39:36 heinz Exp $

DISTNAME=	Chart-2.4.1
PKGNAME=	p5-${DISTNAME}
CATEGORIES=	graphics perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Chart/}

MAINTAINER=	adrianp@NetBSD.org
HOMEPAGE=	http://search.cpan.org/~chartgrp/
COMMENT=	Perl5 charting library

PKG_DESTDIR_SUPPORT=	user-destdir

DEPENDS+=		p5-GD>=1.20:../../graphics/p5-GD

USE_LANGUAGES=		# empty

PERL5_PACKLIST=		auto/Chart/.packlist

post-extract:
	${CHMOD} a-x ${WRKSRC}/Chart/*.pm

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
