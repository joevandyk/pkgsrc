# $NetBSD: Makefile,v 1.2 2007/02/22 12:11:26 wiz Exp $

DISTNAME=	Lingua-Stem-Snowball-0.941
PKGNAME=	p5-${DISTNAME}
CATEGORIES=	textproc perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Lingua/}

MAINTAINER=	kuli0020@umn.edu
HOMEPAGE=	http://search.cpan.org/dist/Lingua-Stem-Snowball/
COMMENT=	Lingua::Stem::Snowball - Perl interface to Snowball stemmers

PERL5_MODULE_TYPE=	Module::Build
PERL5_REQD+=	5.8.0
PERL5_PACKLIST=	auto/Lingua/Stem/Snowball/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
