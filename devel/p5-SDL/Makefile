# $NetBSD: Makefile,v 1.33 2006/06/12 16:28:05 wiz Exp $
#

DISTNAME=	SDL_perl-1.19.2
PKGNAME=	p5-SDL-1.19.2
PKGREVISION=	17
CATEGORIES=	devel perl5
MASTER_SITES=	ftp://sdlperl.org/SDL_perl/

PERL5_OPTIONS+=	threads

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://sdlperl.org/
COMMENT=	Perl module for SDL

PERL5_PACKLIST=		auto/SDL_perl/.packlist

.include "../../audio/SDL_mixer/buildlink3.mk"
.include "../../devel/SDL/buildlink3.mk"
.include "../../devel/SDL_gfx/buildlink3.mk"
.include "../../devel/SDL_ttf/buildlink3.mk"
.include "../../graphics/SDL_image/buildlink3.mk"
.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../lang/perl5/module.mk"
.include "../../multimedia/smpeg/buildlink3.mk"
.include "../../net/SDL_net/buildlink3.mk"

.include "../../mk/bsd.pkg.mk"
