# $NetBSD: Makefile,v 1.16 2006/02/05 23:11:04 joerg Exp $
#

DISTNAME=	XML-Grove-0.46alpha
PKGNAME=	p5-${DISTNAME:S/alpha/.0.1/}
PKGREVISION=	4
SVR4_PKGNAME=	p5xgr
CATEGORIES=	textproc perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=XML/}

MAINTAINER=	explorer@NetBSD.org
#HOMEPAGE=
COMMENT=	Perl 5 module providing simple objects for parsed XML documents

DEPENDS+=	p5-libxml>=0.0.7:../../textproc/p5-libxml

PERL5_PACKLIST=		auto/XML/Grove/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
