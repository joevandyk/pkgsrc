# $NetBSD: Makefile,v 1.5 2005/08/06 06:19:12 jlam Exp $

DISTNAME=	Object-Realize-Later-0.15
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	2
CATEGORIES=	devel perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Object/}

MAINTAINER=	adrianp@stindustries.net
HOMEPAGE=	http://search.cpan.org/dist/Object-Realize-Later/
COMMENT=	Delayed creation of objects

DEPENDS+=	p5-Scalar-List-Utils-[0-9]*:../../devel/p5-Scalar-List-Utils

PKG_INSTALLATION_TYPES=	overwrite pkgviews

PERL5_PACKLIST=	auto/Object/Realize/Later/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
