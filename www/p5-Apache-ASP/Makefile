# $NetBSD: Makefile,v 1.29 2006/06/10 19:53:13 minskim Exp $
#

DISTNAME=	Apache-ASP-2.21
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	6
SVR4_PKGNAME=	p5aas
CATEGORIES=	www perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Apache/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.apache-asp.org/
COMMENT=	Perl5/Apache module of Perl-coded Active Server Pages

DEPENDS+=	p5-Apache-Filter>=1.019:../../www/p5-Apache-Filter
DEPENDS+=	p5-Apache-SSI>=2.16:../../www/p5-Apache-SSI
DEPENDS+=	p5-Compress-Zlib>=1.14:../../devel/p5-Compress-Zlib
DEPENDS+=	p5-Devel-Symdump>=2.00:../../devel/p5-Devel-Symdump
DEPENDS+=	p5-HTML-Clean>=0.8:../../www/p5-HTML-Clean
DEPENDS+=	p5-HTML-FillInForm>=0.8:../../www/p5-HTML-FillInForm
DEPENDS+=	p5-MLDBM>=2.00:../../databases/p5-MLDBM
DEPENDS+=	p5-MLDBM-Sync>=0.15:../../databases/p5-MLDBM-Sync
DEPENDS+=	p5-Time-HiRes>=01.20:../../time/p5-Time-HiRes
DEPENDS+=	p5-XML-XSLT>=0.32:../../textproc/p5-XML-XSLT
DEPENDS+=	p5-libwww>=5.48:../../www/p5-libwww

REPLACE_PERL+=	ASP.pm

PERL5_PACKLIST=		auto/Apache/ASP/.packlist

.include "../../lang/perl5/module.mk"
.include "../../www/ap-perl/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
