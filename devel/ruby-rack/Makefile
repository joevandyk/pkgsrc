# $NetBSD: Makefile,v 1.4 2007/12/13 14:48:09 taca Exp $

DISTNAME=	rack-0.2.0
CATEGORIES=	devel
MASTER_SITES=	http://rubyforge.org/frs/download.php/20773/
EXTRACT_SFX=    .tar.gz

MAINTAINER=	joe@pinkpucker.net
HOMEPAGE=	http://rack.rubyforge.org/
COMMENT=	Ruby webserver interface

BUILD_DEPENDS+=	rake-[0-9]*:../../devel/rake
DEPENDS+=	rubygems-[0-9]*:../../misc/rubygems

REPLACE_RUBY_DIRS=	${WRKSRC}/examples
RUBY_HAS_ARCHLIB=	yes

FIND_PREFIX:=	RAKE_PREFIX=rake
.include "../../mk/find-prefix.mk"

.include "../../lang/ruby/modules.mk"

pre-configure:
	${RM} -f ${WRKSRC}/bin/*.orig

do-build:
	#cd ${WRKSRC} && ${RAKE_PREFIX}/bin/rake package

do-install:
	/opt/local/bin/gem install rack -v0.2.0 --remote

.include "../../mk/bsd.pkg.mk"
