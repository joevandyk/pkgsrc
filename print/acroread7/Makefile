# $NetBSD: Makefile,v 1.20 2007/09/13 20:19:09 wiz Exp $

DISTNAME=	acroread7	# overridden below
PKGNAME=	acroread7-7.0.9
PKGREVISION=	1
CATEGORIES=	print
MASTER_SITES=	http://ardownload.adobe.com/pub/adobe/reader/unix/7x/7.0.9/enu/

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.adobe.com/products/acrobat/readstep2.html
COMMENT=	View, distribute and print PDF documents

CONFLICTS+=	acroread-5.*
# conflict with acroread5 due to bin/acroread
# maybe should do ALTERNATIVES?
CONFLICTS+=	acroread5-5.*

RESTRICTED=		Original installer required to redistribute.
NO_SRC_ON_CDROM=	${RESTRICTED}
NO_BIN_ON_CDROM=	${RESTRICTED}
NO_BIN_ON_FTP=		${RESTRICTED}
NO_SRC_ON_FTP=		${RESTRICTED}
LICENSE=		adobe-acrobat-license

WRKSRC=			${WRKDIR}/AdobeReader
BUILD_DIRS=		# empty

EMUL_PLATFORMS=		linux-i386
EMUL_MODULES.linux=	compat cups gtk2 locale
EMUL_REQD=		suse>=10.0

.include "../../mk/bsd.prefs.mk"

.if ${EMUL_PLATFORM} == "linux-i386"
DISTNAME=	AdobeReader_enu-7.0.9-1.i386
PLATFORM=	intellinux
.else
PLATFORM=	unknown
.endif

PLIST_SUBST+=	PLATFORM=${PLATFORM:Q}

BIN_PATCH=	${PATCH} --quiet ${_PATCH_BACKUP_ARG} .orig

# Additional directories to search for fonts
BUILD_DEFS+=		ACROREAD_FONTPATH
ACROREAD_FONTPATH?=	${PREFIX}/lib/X11/fonts/TTF

INSTALLATION_DIRS=	bin

do-install:
	@${INSTALL_DATA_DIR} ${PREFIX}/Acrobat7
	@( ${ECHO} n; ${ECHO} n ) | InstallDir=${PREFIX}/Acrobat7 ${WRKSRC}/INSTALL

post-install:
	@cd ${PREFIX}/Acrobat7/bin && \
	  ${BIN_PATCH} <${FILESDIR}/acroread.diff && \
	  ${SED} -e 's:@PREFIX@:${PREFIX}:' \
	    -e 's|@ACROREAD_FONTPATH@|${ACROREAD_FONTPATH}|' \
		<acroread >acroread.tmp && \
	  ${MV} acroread.tmp acroread && \
	  ${INSTALL_SCRIPT} ${PREFIX}/Acrobat7/bin/acroread \
	     ${PREFIX}/bin/acroread7 && ${RM} -f acroread.orig acroread.tmp
	${CHMOD} +x ${PREFIX}/bin/acroread7
	@${ECHO_MSG} "Be sure to read the license agreement in"
	@${ECHO_MSG} "${PREFIX}/Acrobat7/Reader/Legal/ENU/License.html"
	${LN} -sf ${PREFIX}/bin/acroread7 ${PREFIX}/bin/acroread
	${RM} ${PREFIX}/Acrobat7/Reader/${PLATFORM}/plug_ins/PPKLite.api

.include "../../mk/bsd.pkg.mk"
