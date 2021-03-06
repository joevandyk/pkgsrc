# $NetBSD: Makefile,v 1.77 2007/02/27 13:52:04 hira Exp $

DISTNAME=		openoffice-1.1.5
PKGREVISION=		2
CATEGORIES=		misc
MASTER_SITES=		${MASTER_SITE_OPENOFFICE:=stable/1.1.5/}
DISTFILES=		OOo_1.1.5_src.tar.gz
DISTFILES+=		gpc231.tar.Z
DISTFILES+=		ooo_addons_115.tar.bz2
SITES.gpc231.tar.Z=	ftp://ftp.cs.man.ac.uk/pub/toby/gpc/
SITES.ooo_addons_115.tar.bz2=http://www.fs.tum.de/~mrauch/OpenOffice/download/\
			ftp://ftp.NetBSD.org/pub/NetBSD/misc/mrauch/
DIST_SUBDIR=		${PKGNAME_NOREV}

MAINTAINER=		mrauch@NetBSD.org
HOMEPAGE=		http://www.openoffice.org/
COMMENT=		Integrated office productivity suite

BUILD_DEPENDS+=		bison-[0-9]*:../../devel/bison
BUILD_DEPENDS+=		{standalone-tcsh,tcsh}-[0-9]*:../../shells/tcsh
BUILD_DEPENDS+=		zip-[0-9]*:../../archivers/zip
BUILD_DEPENDS+=		unzip-[0-9]*:../../archivers/unzip

WRKSRC=			${WRKDIR}/OOo_1.1.5/config_office
GCC_REQD+=		3.0
USE_LANGUAGES=		c c++

.include "../../mk/bsd.prefs.mk"

USE_TOOLS+=		gmake imake perl
PTHREAD_OPTS+=		require
PTHREAD_AUTO_VARS=	yes

CONFLICTS+=		staroffice-[0-9]*
CONFLICTS+=		openoffice2-[0-9]*
CONFLICTS+=		openoffice-bin-[0-9]*
CONFLICTS+=		openoffice-linux-[0-9]*

ONLY_FOR_PLATFORM=	NetBSD-1.6Z[G-Z]*-i386 NetBSD-[2-9]*-i386

GNU_CONFIGURE=		yes
CONFIGURE_ARGS+=	--enable-mozilla --disable-java
CONFIGURE_ARGS+=	--with-lang="AFRIK","ARAB","BASQUE","CHINSIM","CHINTRAD","CZECH","DAN","DTCH","ENUS","ESTONIAN","FINN","FREN","GAL","GREEK","HEBREW","HUNG","ITAL","JAPN","KOREAN","LITHUANIAN","NORBOK","NORNYN","NSOTHO","POL","PORT","PORTBR","RUSS","SLOVAK","SLOVENIAN","SPAN","SWED","TURK","WELSH","ZULU"
CONFIGURE_ARGS+=	--with-dict=ALL

TEMP?=			${WRKDIR}
UNLIMIT_RESOURCES+=	datasize

PLIST_SRC+=		PLIST.common
PLIST_SUBST+=		OPENOFFICE_DLLSUFFIX=${OPENOFFICE_DLLSUFFIX:Q}
PLIST_SUBST+=		OPENOFFICE_VERSION=${OPENOFFICE_VERSION:Q}
.if exists(${PKGDIR}/PLIST.${OPSYS})
PLIST_SRC+=		${PKGDIR}/PLIST.${OPSYS}
. endif
MESSAGE_SUBST+=		OPENOFFICE_VERSION=${OPENOFFICE_VERSION}

OPENOFFICE_VERSION=	OpenOffice.org1.1.5

INSTALLATION_DIRS=	bin

post-extract:
# bring the two files from GPC into place
	${CP} ${WRKDIR}/gpc231/gpc.c ${WRKSRC}/../external/gpc/
	${CP} ${WRKDIR}/gpc231/gpc.h ${WRKSRC}/../external/gpc/
# bring the NetBSD mozilla zip files into place
	${CP} ${WRKDIR}/moz/*.zip ${WRKSRC}/../moz/zipped/
	${CP} ${WRKDIR}/openintro_pkgsrc.bmp 				\
		${WRKSRC}/../offmgr/res/openintro.bmp
# bring the localized helpcontent into place
	${MKDIR} ${WRKSRC}/../helpcontent/${OPENOFFICE_OUTPATH}.pro/bin
	-${CP} ${WRKDIR}/*.zip ${WRKSRC}/../helpcontent/${OPENOFFICE_OUTPATH}.pro/bin/

do-build:
	${_ULIMIT_CMD} tcsh -c "setenv PTHREAD_DIAGASSERT Ael && cd ${WRKSRC}/.. && ./bootstrap && source ${OPENOFFICE_SETFILE}Env.Set && dmake"

post-build:
	@${ECHO_MSG} "Please ignore the warning above that the project gtk"
	@${ECHO_MSG} "could not be found. Your build completed successfully."

pre-install:
	${CP} ${WRKSRC}/../instsetoo/${OPENOFFICE_OUTPATH}.pro/${OPENOFFICE_LANGCODE}/normal/setup.ins 	\
		${WRKSRC}/../instsetoo/${OPENOFFICE_OUTPATH}.pro/${OPENOFFICE_LANGCODE}/normal/setup.ins.orig
	${SED}  -e "s|/usr/bin/soffice|${PREFIX}/bin/soffice.orig|g"	\
		-e "s|/usr/lib||g"					\
		<${WRKSRC}/../instsetoo/${OPENOFFICE_OUTPATH}.pro/${OPENOFFICE_LANGCODE}/normal/setup.ins.orig\
		>${WRKSRC}/../instsetoo/${OPENOFFICE_OUTPATH}.pro/${OPENOFFICE_LANGCODE}/normal/setup.ins

do-install:
	cd ${WRKSRC}/../instsetoo/${OPENOFFICE_OUTPATH}.pro/${OPENOFFICE_LANGCODE}/normal; ${SETENV} TEMP=${TEMP} ./install --prefix=${PREFIX}
	${TOUCH} ${PREFIX}/${OPENOFFICE_VERSION}/help/${OPENOFFICE_HELPCODE}/common.tree
	${TOUCH} ${PREFIX}/${OPENOFFICE_VERSION}/help/${OPENOFFICE_HELPCODE}/schart.tree
	${TOUCH} ${PREFIX}/${OPENOFFICE_VERSION}/help/${OPENOFFICE_HELPCODE}/sdraw.tree
	${RM} -f ${PREFIX}/bin/soffice.orig
	${SED}	-e "s|@@PREFIX@@|${PREFIX}|g"				\
		-e "s|@@OPENOFFICE_VERSION@@|${OPENOFFICE_VERSION}|g"	\
		< ${FILESDIR}/soffice > ${PREFIX}/bin/soffice
	${CHMOD} +x ${PREFIX}/bin/soffice
.for i in scalc sdraw simpress swriter
	${LN} -sf ${PREFIX}/${OPENOFFICE_VERSION}/program/${i} ${PREFIX}/bin/${i}
.endfor

# everything specific to your OS/Arch goes into its own Makefile
# group together i386, i486, i586 and i686 (for Linux)
#
ARCH=	${MACHINE_ARCH:C/i[3-6]86/i386/g}

.if exists(Makefile.${OPSYS}.${ARCH})
.  include "Makefile.${OPSYS}.${ARCH}"
.endif

# everything related to i18n is in a separate file
.include "Makefile.i18n"

PLIST_SRC+=		PLIST.common_end

.include "../../mk/compiler.mk"
.include "../../mk/pthread.buildlink3.mk"
.include "../../textproc/libxslt/buildlink3.mk"
.include "../../mk/x11.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
