# $NetBSD: Makefile,v 1.10 2006/03/04 21:29:04 jlam Exp $
#

DISTNAME=	Net-Jabber-1.26
PKGNAME=	p5-${DISTNAME}
PKGREVISION=	4
CATEGORIES=	chat perl5
MASTER_SITES=	${MASTER_SITE_PERL_CPAN:=Net/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.jabber.org/
COMMENT=	Provide a Perl Developer access to the Jabber protocol

DEPENDS+=	p5-Unicode-String-[0-9]*:../../converters/p5-Unicode-String
DEPENDS+=	p5-XML-Stream-[0-9]*:../../textproc/p5-XML-Stream
DEPENDS+=	p5-Digest-SHA1-[0-9]*:../../security/p5-Digest-SHA1
DEPENDS+=	p5-Time-[0-9]*:../../time/p5-Time

PERL5_PACKLIST=	auto/Net/Jabber/.packlist

.include "../../lang/perl5/module.mk"
.include "../../mk/bsd.pkg.mk"
