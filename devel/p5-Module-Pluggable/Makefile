# $NetBSD: Makefile,v 1.7 2007/05/27 09:16:28 heinz Exp $
#

DISTNAME=	Module-Pluggable-3.6
PKGNAME=	p5-${DISTNAME}
SVR4_PKGNAME=	p5mpl
CATEGORIES=	devel perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Module/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://search.cpan.org/dist/Module-Pluggable/
COMMENT=	Perl 5 module for automatically adding the ability to have plugins to modules

PKG_DESTDIR_SUPPORT=	user-destdir

USE_LANGUAGES=		# empty
PERL5_PACKLIST=		auto/Module/Pluggable/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
