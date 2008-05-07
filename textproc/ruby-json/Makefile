# $NetBSD$
#

DISTNAME=	json-${VERSION}
PKGNAME=        ruby_json-${VERSION}
CATEGORIES=	textproc
MASTER_SITES=	http://rubyforge.org/frs/download.php/28483/
EXTRACT_SUFX=	.tgz

VERSION = 1.1.2

MAINTAINER=	joe@pinkpucker.net
HOMEPAGE=	http://json.rubyforge.org/
COMMENT=	JSON library for ruby
FIND_PREFIX:=	RAKE_PREFIX=rake
.include "../../mk/find-prefix.mk"

BUILD_DEPENDS+=	rake>=0.7.3:../../devel/rake

do-build:
	cd ${WRKSRC} && ${RAKE_PREFIX}/bin/rake install
do-install:

.include "../../lang/ruby/modules.mk"
.include "../../mk/bsd.pkg.mk"
