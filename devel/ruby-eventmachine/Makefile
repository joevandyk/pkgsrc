# $NetBSD: Makefile,v 1.4 2007/12/13 14:48:09 taca Exp $

DISTNAME=	eventmachine-0.10.0
CATEGORIES=	devel
MASTER_SITES=	http://rubyforge.org/frs/download.php/28958/

MAINTAINER=	joe@pinkpucker.net
HOMEPAGE=	http://eventmachine.rubyforge.org
COMMENT=	Event machine

BUILD_DEPENDS+=	rake-[0-9]*:../../devel/rake
DEPENDS+=	rubygems-[0-9]*:../../misc/rubygems

USE_LANGUAGES= c++

RUBY_HAS_ARCHLIB=	yes

pre-configure:
	${RM} -f ${WRKSRC}/bin/*.orig

do-build:
	#cd ${WRKSRC} && ${RAKE_PREFIX}/bin/rake package

do-install:
	#/opt/local/bin/gem install eventmachine -v0.10.0 --remote

.include "../../mk/bsd.pkg.mk"
