# $NetBSD: Makefile,v 1.8 2007/03/24 07:18:11 schmonz Exp $

DISTNAME=	XML-RAI-0.51
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	4
CATEGORIES=	textproc perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=XML/}

MAINTAINER=	pkgsrc-users@NetBSD.org
COMMENT=	Maps RSS tags to one common simplified interface

DEPENDS+=	p5-XML-RSS-Parser>=2.15:../../textproc/p5-XML-RSS-Parser
DEPENDS+=	p5-TimeDate>=1.14:../../time/p5-TimeDate

PKG_INSTALLATION_TYPES=	overwrite pkgviews

PERL5_PACKLIST=		auto/XML/RAI/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
