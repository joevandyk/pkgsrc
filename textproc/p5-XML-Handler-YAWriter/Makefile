# $NetBSD: Makefile,v 1.8 2006/03/04 21:30:49 jlam Exp $
#

DISTNAME=	XML-Handler-YAWriter-0.23
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	5
SVR4_PKGNAME=	p5xhy
CATEGORIES=	textproc perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=XML/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://search.cpan.org/dist/XML-Handler-YAWriter/
COMMENT=	Another Perl module for writing XML documents

PKG_INSTALLATION_TYPES=	overwrite pkgviews

# really: XML::Parser::PerlSAX' => 0.06
DEPENDS+=		p5-libxml>=0.07:../../textproc/p5-libxml

PERL5_PACKLIST=		auto/XML/Handler/YAWriter/.packlist
REPLACE_PERL=		xmlpretty

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
