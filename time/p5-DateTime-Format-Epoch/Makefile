# $NetBSD: Makefile,v 1.3 2005/08/06 06:19:35 jlam Exp $

DISTNAME=	DateTime-Format-Epoch-0.09
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	1
CATEGORIES=	time perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=DateTime/}

MAINTAINER=	bouyer@NetBSD.org
HOMEPAGE=	http://datetime.perl.org/
COMMENT=	Convert DateTimes to/from epoch seconds

DEPENDS+=	p5-DateTime-[0-9]*:../../time/p5-DateTime

PERL5_PACKLIST=		auto/DateTime/Format/Epoch/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
