# $NetBSD: Makefile,v 1.50 2007/09/25 10:07:05 hira Exp $

DISTNAME=		bochs-2.3
CATEGORIES=		emulators
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=bochs/}

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://bochs.sourceforge.net/
COMMENT=		IA32 and AMD64 PC emulator

GNU_CONFIGURE=		yes
USE_TOOLS+=		gmake
USE_TOOLS+=		gunzip gzip
USE_LANGUAGES=		c c++

ONLY_FOR_COMPILER=	gcc
CXXFLAGS+=		-DPARANOID

CONFIGURE_ARGS+=	--enable-cdrom
CONFIGURE_ARGS+=	--enable-ne2000

MAKE_ENV+=		GZIP_CMD=${GZIP_CMD:Q}
MAKE_ENV+=		GUNZIP_CMD=${GUNZIP_CMD:Q}
MAKE_ENV+=		WGET=${FETCH_CMD:Q}

PKG_OPTIONS_VAR=	PKG_OPTIONS.bochs
PKG_SUPPORTED_OPTIONS+=	debug tiny

.include "../../mk/bsd.prefs.mk"
.include "../../mk/bsd.options.mk"

# Debugging features for the client operating systems.  These options are
# not enabled by default because they can adversely impact performance.
.if !empty(PKG_OPTIONS:Mdebug)
CONFIGURE_ARGS+=	--enable-debugger
CONFIGURE_ARGS+=	--enable-disasm
CONFIGURE_ARGS+=	--enable-iodebug
CONFIGURE_ARGS+=	--enable-x86-debugger
.endif

.if empty(PKG_OPTIONS:Mtiny)
CONFIGURE_ARGS+=	--enable-3dnow
CONFIGURE_ARGS+=	--enable-4meg-pages
CONFIGURE_ARGS+=	--enable-all-optimizations
CONFIGURE_ARGS+=	--enable-apic
CONFIGURE_ARGS+=	--enable-cpu-level=6
CONFIGURE_ARGS+=	--enable-daz
CONFIGURE_ARGS+=	--enable-fpu
CONFIGURE_ARGS+=	--enable-global-pages
CONFIGURE_ARGS+=	--enable-guest2host-tlb
CONFIGURE_ARGS+=	--enable-host-specific-asms
CONFIGURE_ARGS+=	--enable-icache
CONFIGURE_ARGS+=	--enable-mmx
CONFIGURE_ARGS+=	--enable-new-pit
CONFIGURE_ARGS+=	--enable-pae
CONFIGURE_ARGS+=	--enable-pci
CONFIGURE_ARGS+=	--enable-repeat-speedups
CONFIGURE_ARGS+=	--enable-sep
CONFIGURE_ARGS+=	--enable-sse=3
CONFIGURE_ARGS+=	--enable-usb
CONFIGURE_ARGS+=	--enable-vbe
CONFIGURE_ARGS+=	--enable-x86-64

.  if !empty(MACHINE_PLATFORM:M*-*-i386)
CONFIGURE_ARGS+=	--enable-fast-function-calls
.  endif

.  if ${OPSYS} == "Darwin"
CONFIGURE_ARGS+=	--enable-sb16=osx
.  elif ${OPSYS} == "FreeBSD"
CONFIGURE_ARGS+=	--enable-sb16=freebsd
.  elif ${OPSYS} == "Linux"
CONFIGURE_ARGS+=	--enable-sb16=linux
.  else
CONFIGURE_ARGS+=	--enable-sb16=dummy
.  endif
.endif

.if ${OPSYS} == "Linux"
BOCHSRC_SUBST+=		-e 's,@FLOPPY_BSD@,\#,'
BOCHSRC_SUBST+=		-e 's,@FLOPPY_LINUX@,,'
.elif ${OPSYS} == "Darwin"
BOCHSRC_SUBST+=		-e 's,@FLOPPY_BSD@,\#,'
BOCHSRC_SUBST+=		-e 's,@FLOPPY_LINUX@,\#,'
.else
BOCHSRC_SUBST+=		-e 's,@FLOPPY_BSD@,,'
BOCHSRC_SUBST+=		-e 's,@FLOPPY_LINUX@,\#,'
.endif

.if ${OPSYS} == "Darwin"
INSTALL_MAKE_FLAGS+=	prefix=${PREFIX}/libexec/bochs
MESSAGE_SRC=		${.CURDIR}/MESSAGE.Darwin
PLIST_SRC=		${.CURDIR}/PLIST.Darwin

post-build:
	{ ${ECHO} '#! ${SH}'; \
	  ${ECHO} 'exec ${PREFIX}/libexec/bochs/bochs.app/Contents/MacOS/bochs'\
	          '"$$@"'; } >${WRKDIR}/bochs.sh

post-install:
	${INSTALL_SCRIPT} ${WRKDIR}/bochs.sh ${PREFIX}/bin/bochs
	${LN} -fs ${PREFIX}/libexec/bochs/bxcommit ${PREFIX}/bin/bxcommit
	${LN} -fs ${PREFIX}/libexec/bochs/bximage ${PREFIX}/bin/bximage
.else
BUILDLINK_DEPMETHOD.libXt?=	build

.  include "../../x11/libSM/buildlink3.mk"
.  include "../../x11/libX11/buildlink3.mk"
.  include "../../x11/libXpm/buildlink3.mk"
.  include "../../x11/libXt/buildlink3.mk"
.endif

pre-configure:
	${SED} ${BOCHSRC_SUBST} <${WRKSRC}/.bochsrc >${WRKSRC}/.bochsrc.new
	mv ${WRKSRC}/.bochsrc.new ${WRKSRC}/.bochsrc

.include "../../mk/bsd.pkg.mk"
