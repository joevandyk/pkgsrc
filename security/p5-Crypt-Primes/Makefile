# $NetBSD: Makefile,v 1.13 2005/08/06 06:19:30 jlam Exp $
#

DISTNAME=		Crypt-Primes-0.50
PKGNAME=		p5-${DISTNAME}
SVR4_PKGNAME=		p5cpr
PKGREVISION=		2
CATEGORIES=		security perl5
MASTER_SITES=		${MASTER_SITE_PERL_CPAN:=Crypt/}

MAINTAINER=		heinz@NetBSD.org
HOMEPAGE=		http://search.cpan.org/dist/Crypt-Primes/
COMMENT=		Perl5 module for provable prime number generation

DEPENDS+=		p5-Math-Pari>=2.001804:../../math/p5-Math-Pari
DEPENDS+=		p5-Crypt-Random>=0.33:../../security/p5-Crypt-Random

PKG_INSTALLATION_TYPES=	overwrite pkgviews

USE_LANGUAGES=		# empty
PERL5_PACKLIST=		auto/Crypt/Primes/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
