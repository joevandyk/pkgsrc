# $NetBSD: Makefile,v 1.5 2005/08/06 06:19:09 jlam Exp $
#

DISTNAME=		Class-XPath-1.4
PKGNAME=		p5-${DISTNAME}
PKGREVISION=		2
CATEGORIES=		devel perl5
MASTER_SITES=		${MASTER_SITE_PERL_CPAN:=Class/}

MAINTAINER=		schmonz@NetBSD.org
COMMENT=		Perl5 module for XPath-style matching in object trees

PKG_INSTALLATION_TYPES=	overwrite pkgviews

PERL5_PACKLIST=		auto/Class/XPath/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
