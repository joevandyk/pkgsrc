# $NetBSD: Makefile,v 1.4 2007/12/13 14:48:09 taca Exp $

DISTNAME=	thin-0.8.1
CATEGORIES=	www
MASTER_SITES=	http://rubyforge.org/frs/download.php/35794/
EXTRACT_SUFX=	.gem

MAINTAINER=	joe@pinkpucker.net
HOMEPAGE=	http://code.macournoyer.com/thin/
COMMENT=	Fast HTTP library and server for Ruby

BUILD_DEPENDS+=	rake-[0-9]*:../../devel/rake
DEPENDS+=	rubygems-[0-9]*:../../misc/rubygems

RUBY_HAS_ARCHLIB=	yes

FIND_PREFIX:=	RAKE_PREFIX=rake
.include "../../mk/find-prefix.mk"

.include "../../lang/ruby/modules.mk"

do-build:

do-install:

.include "../../mk/bsd.pkg.mk"
