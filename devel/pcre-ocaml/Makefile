# $NetBSD: Makefile,v 1.4 2007/06/09 11:05:00 rillig Exp $
#

DISTNAME=		pcre-ocaml-5.11.2
CATEGORIES=		devel
MASTER_SITES=		http://www.ocaml.info/ocaml_sources/
EXTRACT_SUFX=		.tar.bz2

MAINTAINER=		rillig@NetBSD.org
HOMEPAGE=		http://www.ocaml.info/ocaml_sources/
COMMENT=		Perl compatible regular expressions for OCaml

DEPENDS+=		ocaml-findlib-[0-9]*:../../devel/ocaml-findlib

.include "../../mk/bsd.prefs.mk"

USE_TOOLS+=		gmake
.if (${MACHINE_ARCH} == "i386") || (${MACHINE_ARCH} == "powerpc") || \
    (${MACHINE_ARCH} == "sparc") || (${MACHINE_ARCH} == "x86_64")
PLIST_SRC=		PLIST PLIST.opt
.else
BUILD_TARGET=		byte
.endif

EGDIR=			${PREFIX}/share/examples/pcre-ocaml
INSTALLATION_DIRS=	${EGDIR}

post-install:
	cd ${WRKSRC}/examples && ${PAX} -rw -pm . ${EGDIR}

.include "../../devel/pcre/buildlink3.mk"
.include "../../lang/ocaml/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
