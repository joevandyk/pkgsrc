# $NetBSD: Makefile,v 1.11 2006/03/21 06:00:49 jlam Exp $
#

DISTNAME=	dtdparse-2.0beta6
PKGREVISION=	6
CATEGORIES=	textproc
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=dtdparse/}

MAINTAINER=	minskim@NetBSD.org
HOMEPAGE=	http://dtdparse.sourceforge.net/
COMMENT=	Reads an SGML or XML DTD and constructs an XML database

DEPENDS+=	p5-XML-Parser-[0-9]*:../../textproc/p5-XML-Parser
DEPENDS+=	p5-XML-DOM-[0-9]*:../../textproc/p5-XML-DOM
DEPENDS+=	p5-Text-DelimMatch-[0-9]*:../../textproc/p5-Text-DelimMatch

DOCDIR=		${PREFIX}/share/doc/dtdparse
EGDIR=		${PREFIX}/share/examples/dtdparse
XMLDIR=		${PREFIX}/share/xml/dtdparse
XML_CATALOGS=	${XMLDIR}/catalog
SCRIPTS=	dtdflatten dtdformat dtdparse \
		tools/contentmodel tools/dtdstats tools/elements

INSTALLATION_DIRS=	bin

do-build:
	cd ${WRKSRC}; \
		${PERL5} -pi -e 's,/usr/local/bin/perl5,${PERL5},' ${SCRIPTS}
	${PERL5} -pi -e 's,modules/,XML/DTDParse/,' ${WRKSRC}/dtdformat

do-install:
	cd ${WRKSRC}; ${INSTALL_SCRIPT} ${SCRIPTS} ${PREFIX}/bin
	${MKDIR} ${PERL5_INSTALLVENDORLIB}/XML/DTDParse
	${INSTALL_DATA} ${WRKSRC}/XML/DTDParse/*.pm ${WRKSRC}/modules/*.pl \
		${PERL5_INSTALLVENDORLIB}/XML/DTDParse
	${MKDIR} ${XMLDIR}
	${INSTALL_DATA} ${WRKSRC}/dtd.dtd ${XMLDIR}
	${INSTALL_DATA} ${FILESDIR}/catalog ${XMLDIR}/catalog

post-install:
	${MKDIR} ${EGDIR}
	cd ${WRKSRC}/sample; \
		${INSTALL_DATA} sample* simple* ${EGDIR}
	${MKDIR} ${DOCDIR}
	cd ${WRKSRC}; ${INSTALL_DATA} README WhatsNew ${DOCDIR}

.include "../../lang/perl5/module.mk"
.include "../../textproc/xmlcatmgr/catalogs.mk"
.include "../../mk/bsd.pkg.mk"
