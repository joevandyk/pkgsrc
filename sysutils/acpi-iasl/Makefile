# $NetBSD: Makefile,v 1.10 2007/08/17 20:14:55 joerg Exp $
#

DISTNAME=	acpica-unix-${ACPI_IASL_VERSION}
PKGNAME=	acpi-iasl-${ACPI_IASL_VERSION}
CATEGORIES=	devel
MASTER_SITES=	http://www.intel.com/technology/iapc/acpi/downloads/

MAINTAINER=	uebayasi@NetBSD.org
HOMEPAGE=	http://www.intel.com/technology/iapc/acpi/downloads.htm
COMMENT=	Compiler of Intel ACPI CA - Unix Build Environment

ACPI_IASL_VERSION=	20060217

PKG_INSTALLATION_TYPES=	overwrite pkgviews
PKG_DESTDIR_SUPPORT=	user-destdir

INSTALLATION_DIRS=	bin share/doc/acpi-iasl

USE_TOOLS+=	bison flex gm4 gmake

do-build:
	@cd ${WRKSRC}/compiler && ${MAKE_PROGRAM}
	@cd ${WRKSRC}/tools/acpisrc && ${MAKE_PROGRAM}

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/compiler/iasl ${DESTDIR}${PREFIX}/bin/acpi-iasl
	${INSTALL_PROGRAM} ${WRKSRC}/tools/acpisrc/acpisrc ${DESTDIR}${PREFIX}/bin/acpisrc
	${INSTALL_DATA} ${WRKSRC}/README ${DESTDIR}${PREFIX}/share/doc/acpi-iasl
	${INSTALL_DATA} ${FILESDIR}/LICENSE ${DESTDIR}${PREFIX}/share/doc/acpi-iasl

.include "../../mk/bsd.pkg.mk"
