#	$NetBSD: cross.mk,v 1.38 2006/07/27 18:48:02 jlam Exp $

# Shared definitions for building a cross-compile environment.

.include "../../mk/bsd.prefs.mk"

DISTNAME=		cross-${TARGET_ARCH}-${DISTVERSION}
CATEGORIES+=		cross lang
USE_CROSSBASE=		yes
PLIST_SRC=		${WRKDIR}/.PLIST_SRC

HOMEPAGE?=		http://egcs.cygnus.com/

TARGET_DIR=		${PREFIX}/${TARGET_ARCH}
COMMON_DIR=		${PKGSRCDIR}/cross/COMMON
PLIST_PRE?=		${PKGDIR}/PLIST
MESSAGE_SUBST+=		CROSSBASE=${CROSSBASE}

pre-install: pre-install-dirs
pre-install-dirs:
	${INSTALL_DATA_DIR} ${PREFIX}
	${INSTALL_DATA_DIR} ${PREFIX}/bin
	${INSTALL_DATA_DIR} ${PREFIX}/lib
	${INSTALL_DATA_DIR} ${TARGET_DIR}
	${INSTALL_DATA_DIR} ${TARGET_DIR}/bin
	${INSTALL_DATA_DIR} ${TARGET_DIR}/include
	${INSTALL_DATA_DIR} ${TARGET_DIR}/lib

.if defined(USE_CROSS_BINUTILS)
BINUTILS_DISTNAME=	binutils-2.15
BINUTILS_WRKSRC=	${WRKDIR}/${BINUTILS_DISTNAME}

# Don't use optimizations taken from /etc/mk.conf for the native compiler
CFLAGS=			# empty
CXXFLAGS=		# empty

CROSS_DISTFILES+=	${BINUTILS_DISTNAME}.tar.gz
SITES.${BINUTILS_DISTNAME}.tar.gz+=		${MASTER_SITE_GNU:=binutils/}
CONFIGURE_ARGS+=	--with-gnu-as --with-gnu-ld
DEPENDS+=		cross-binutils>=2.15.0.0:../../cross/binutils
PLIST_PRE+=		${COMMON_DIR}/PLIST-binutils

AS_FOR_TARGET=		${BINUTILS_WRKSRC}/gas/as-new
AR_FOR_TARGET=		${WRKDIR}/ar
NM_FOR_TARGET=		${WRKDIR}/nm
RANLIB_FOR_TARGET=	${WRKDIR}/ranlib
LD_FOR_TARGET=		${WRKDIR}/ld
USE_TOOLS+=		patch

pre-patch: binutils-patch
pre-configure: binutils-configure
do-build: binutils-build
do-install: binutils-install

binutils-patch:
	@for i in ${COMMON_DIR}/patches-binutils/patch-*; do \
		${PATCH} -d ${BINUTILS_WRKSRC} --forward --quiet -E < $$i; \
	done

BFD64ARG=	--enable-64-bit-bfd

binutils-configure:
	@cd ${BINUTILS_WRKSRC} && ${SETENV} CC="${CC}" ac_cv_path_CC="${CC}" \
		CFLAGS="${CFLAGS}" ${CONFIGURE_ENV} ./configure \
		--prefix=${PREFIX} --host=${MACHINE_GNU_ARCH}--netbsd \
		--target=${TARGET_ARCH} ${BFD64ARG}
	cd ${BINUTILS_WRKSRC} && ${MAKE_PROGRAM} configure-bfd
	cd ${BINUTILS_WRKSRC} && ${MAKE_PROGRAM} configure-libiberty
	cd ${BINUTILS_WRKSRC} && ${MAKE_PROGRAM} configure-intl
	cd ${BINUTILS_WRKSRC} && ${MAKE_PROGRAM} configure-gas

binutils-build:
	@cd ${BINUTILS_WRKSRC}/bfd && ${SETENV} ${MAKE_ENV} \
		${MAKE_PROGRAM} ${MAKE_FLAGS} bfd.h
	@cd ${BINUTILS_WRKSRC}/libiberty && ${SETENV} ${MAKE_ENV} \
		${MAKE_PROGRAM} ${MAKE_FLAGS} all
	@cd ${BINUTILS_WRKSRC}/intl && ${SETENV} ${MAKE_ENV} \
		${MAKE_PROGRAM} ${MAKE_FLAGS} all
	@cd ${BINUTILS_WRKSRC}/gas && ${SETENV} ${MAKE_ENV} \
		${MAKE_PROGRAM} ${MAKE_FLAGS} as-new
	${TEST} -x ${WRKDIR}/ar || ${LINK.c} -o ${WRKDIR}/ar \
		-DPREFIX=\"${PREFIX}\" \
		-DGNUTARGET=\"${BINUTILS_GNUTARGET}\" \
		${COMMON_DIR}/buwrapper.c
	@cd ${WRKDIR} && \
		${LN} -f ar nm && \
		${LN} -f ar ranlib
	${TEST} -x ${WRKDIR}/ld || ${LINK.c} -o ${WRKDIR}/ld \
		-DPREFIX=\"${PREFIX}\" \
		-DGNUTARGET=\"${BINUTILS_GNUTARGET}\" \
		-DLDEMULATION=\"${BINUTILS_LDEMULATION}\" \
		-DLD_RPATH_LINK=\"${TARGET_DIR}/lib\" \
		${COMMON_DIR}/buwrapper.c

binutils-install:
	${INSTALL_PROGRAM} ${BINUTILS_WRKSRC}/gas/as-new ${TARGET_DIR}/bin/as
	${INSTALL_PROGRAM} ${WRKDIR}/ar ${TARGET_DIR}/bin/ar
	${INSTALL_PROGRAM} ${WRKDIR}/ld ${TARGET_DIR}/bin/ld
	for i in addr2line nm objcopy objdump ranlib size strings strip ${BINUTILS_EXTRAS}; do \
		${LN} -f ${TARGET_DIR}/bin/ar ${TARGET_DIR}/bin/$$i; \
	done
	for i in addr2line ar as ld nm objcopy objdump ranlib size strings strip ${BINUTILS_EXTRAS}; do \
		${LN} -f ${TARGET_DIR}/bin/$$i ${PREFIX}/bin/${TARGET_ARCH}-$$i; \
	done
.endif

.if defined(USE_CROSS_EGCS)
EGCS_DISTNAME=		egcs-1.1.1
EGCS_DISTDIR=		releases/${EGCS_DISTNAME}
EGCS_INTVERSION=	egcs-2.91.60
EGCS_PATCHBUNDLE=	${EGCS_DISTNAME}-NetBSD-19980104.diff.gz
EGCS_WRKSRC=		${WRKDIR}/${EGCS_DISTNAME}
EGCS_LANGUAGES=		c # add to these below

# only using autoheader; 2.13 and 2.54 both work fine
USE_TOOLS+=		autoconf

.if defined(EGCS_MULTILIB)
EGCS_INSTALL_LIB=install-multilib
.else
EGCS_INSTALL_LIB=install-libgcc
.endif

.if defined(EGCS_NO_RUNTIME) || defined(EGCS_FAKE_RUNTIME)
EGCS_NO_CXX_RUNTIME=	yes
EGCS_NO_F77_RUNTIME=	yes
EGCS_NO_OBJC_RUNTIME=	yes
.endif

.if !defined(EGCS_NO_CXX)
CXX_CONFIGURE_ARGS+=	--with-gxx-include-dir=${TARGET_DIR}/include/g++
EGCS_LANGUAGES+=	c++
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-cxx
.if !defined(EGCS_NO_CXX_RUNTIME)
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-cxx-runtime
.endif
.endif

.if !defined(EGCS_NO_F77)
EGCS_LANGUAGES+=	f77
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-f77
.if !defined(EGCS_NO_F77_RUNTIME)
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-f77-runtime
.endif
.endif

.if !defined(EGCS_NO_OBJC)
EGCS_LANGUAGES+=	objc
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-objc
.if !defined(EGCS_NO_OBJC_RUNTIME)
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs-objc-runtime
.endif
.endif

# the main PLIST needs to go last to get the @dirrm's right
PLIST_PRE+=		${COMMON_DIR}/PLIST-egcs
CROSS_DISTFILES+=	${EGCS_DISTNAME}.tar.gz ${EGCS_PATCHBUNDLE}
SITES.${EGCS_DISTNAME}.tar.gz=		# no known-good site; fall back to distfiles mirrors
SITES.${EGCS_PATCHBUNDLE}=		${MASTER_SITE_LOCAL}
USE_TOOLS+=		gmake

CC_FOR_TARGET=		${EGCS_WRKSRC}/gcc/xgcc -B${EGCS_WRKSRC}/gcc/ ${CFLAGS_FOR_TARGET}
CXX_FOR_TARGET=		${CC_FOR_TARGET}

USE_TOOLS+=		chmod
EGCS_MAKE_FLAGS=	CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
			CC_FOR_TARGET="${CC_FOR_TARGET}" \
			GCC_FOR_TARGET="${CC_FOR_TARGET}" \
			CXX_FOR_TARGET="${CXX_FOR_TARGET}" \
			AS_FOR_TARGET="${AS_FOR_TARGET}" \
			AR_FOR_TARGET="${AR_FOR_TARGET}" \
			NM_FOR_TARGET="${NM_FOR_TARGET}" \
			RANLIB_FOR_TARGET="${RANLIB_FOR_TARGET}" \
			LDFLAGS_FOR_TARGET="${LDFLAGS_FOR_TARGET}" \
			LANGUAGES="${EGCS_LANGUAGES}" \
			INSTALL="${INSTALL} -c -o ${BINOWN} -g ${BINGRP}" \
			INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
			ac_cv_path_ac_cv_prog_chmod="${TOOLS_CHMOD}"
EGCS_MAKE=		${SETENV} ${MAKE_ENV} \
	                ${MAKE_PROGRAM} ${MAKE_FLAGS} ${EGCS_MAKE_FLAGS}

.if defined(EGCS_FAKE_RUNTIME)
CROSS_SYS_INCLUDE=		${WRKDIR}/include
.endif
.if defined(CROSS_SYS_INCLUDE)
CFLAGS_FOR_TARGET+=	-idirafter ${CROSS_SYS_INCLUDE}
EGCS_MAKE_FLAGS+=	SYSTEM_HEADER_DIR="${CROSS_SYS_INCLUDE}"
.endif
.if defined(SYS_LIB)
LDFLAGS_FOR_TARGET+=	-L${SYS_LIB}
.endif

pre-patch: egcs-patch
pre-configure: egcs-configure
do-build: egcs-build
do-install: egcs-install

egcs-patch:
	@${GZCAT} ${_DISTDIR}/${EGCS_PATCHBUNDLE} | \
		${PATCH} -d ${EGCS_WRKSRC} --forward --quiet -E
	@for i in ${COMMON_DIR}/patches-egcs/patch-*; do \
		${PATCH} -d ${EGCS_WRKSRC} --forward --quiet -E < $$i; \
	done

egcs-configure:
	@cd ${EGCS_WRKSRC} && ${SETENV} CC="${CC}" ac_cv_path_CC="${CC}" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
		INSTALL="${INSTALL} -c -o ${BINOWN} -g ${BINGRP}" \
		INSTALL_PROGRAM="${INSTALL_PROGRAM}" \
		./configure --prefix=${PREFIX} \
		--host=${MACHINE_GNU_ARCH}--netbsd  --target=${TARGET_ARCH} \
		${CXX_CONFIGURE_ARGS}
.if defined(EGCS_FAKE_RUNTIME)
	@${MKDIR} ${CROSS_SYS_INCLUDE} ${CROSS_SYS_INCLUDE}/machine \
		${CROSS_SYS_INCLUDE}/sys
	@cd ${CROSS_SYS_INCLUDE} && ${TOUCH} ${TOUCH_FLAGS} machine/ansi.h \
		sys/time.h stdlib.h unistd.h
.endif

egcs-build:
	@${LN} -sf ${AS_FOR_TARGET} ${EGCS_WRKSRC}/gcc/as
	@${LN} -sf ${LD_FOR_TARGET} ${EGCS_WRKSRC}/gcc/ld
	@cd ${EGCS_WRKSRC}/gcc && ${EGCS_MAKE} all
.if !defined(EGCS_NO_CXX) && !defined(EGCS_NO_CXX_RUNTIME)
	@cd ${EGCS_WRKSRC} && ${EGCS_MAKE} configure-target-libio configure-target-libstdc++ all-target-libio all-target-libstdc++
.endif
.if !defined(EGCS_NO_F77) && !defined(EGCS_NO_F77_RUNTIME)
	@cd ${EGCS_WRKSRC} && ${EGCS_MAKE} configure-target-libf2c all-target-libf2c
.endif
.if !defined(EGCS_NO_OBJC) && !defined(EGCS_NO_OBJC_RUNTIME)
	@cd ${EGCS_WRKSRC}/gcc && ${EGCS_MAKE} objc-runtime
.endif

egcs-install:
	@cd ${EGCS_WRKSRC}/gcc && ${SETENV} ${MAKE_ENV} \
		${MAKE_PROGRAM} ${MAKE_FLAGS} ${EGCS_MAKE_FLAGS} \
		install-common install-headers ${EGCS_INSTALL_LIB} install-driver
	${CHOWN} -R ${BINOWN}:${BINGRP} ${PREFIX}/lib/gcc-lib/${TARGET_ARCH}/${EGCS_INTVERSION}
	${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-gcc ${PREFIX}/bin/${TARGET_ARCH}-cc
	${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-gcc ${TARGET_DIR}/bin/cc
.if !defined(EGCS_NO_F77)
.if !defined(EGCS_NO_F77_RUNTIME)
	@cd ${EGCS_WRKSRC} && ${EGCS_MAKE} install-target-libf2c
.endif
	${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-g77 ${PREFIX}/bin/${TARGET_ARCH}-f77
	${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-g77 ${PREFIX}/bin/${TARGET_ARCH}-fort77
	for file in f77 fort77 g77; do \
		${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-$$file ${TARGET_DIR}/bin/$$file; \
	done
.endif
.if !defined(EGCS_NO_CXX)
.if !defined(EGCS_NO_CXX_RUNTIME)
	@${MKDIR} ${TARGET_DIR}/include/g++/std
	@cd ${EGCS_WRKSRC} && ${EGCS_MAKE} install-target-libstdc++
.endif
	for file in c++ c++filt g++; do \
		${LN} -f ${PREFIX}/bin/${TARGET_ARCH}-$$file ${TARGET_DIR}/bin/$$file; \
	done
.endif
	@${RMDIR} -p ${PREFIX}/info 2>/dev/null || ${TRUE}
	@${RMDIR} -p ${PREFIX}/man/man1 2>/dev/null || ${TRUE}
.endif

.if defined(CROSS_DISTFILES)
DISTFILES+=		${CROSS_DISTFILES}
.if defined(EXTRACT_ONLY)
EXTRACT_ONLY+=		${CROSS_DISTFILES:N*.diff.gz}
.else
EXTRACT_ONLY=		${DISTFILES:N*.diff.gz}
.endif
.endif

.if defined(CROSS_SYS_INCLUDE) && !defined(EGCS_FAKE_RUNTIME)
pre-install: pre-install-includes
pre-install-includes:
	cd ${CROSS_SYS_INCLUDE} && ${PAX} -rw . ${TARGET_DIR}/include
.endif

.if defined(SYS_LIB)
pre-install: pre-install-lib
pre-install-lib:
	cd ${SYS_LIB} && ${PAX} -rw . ${TARGET_DIR}/lib
.endif

post-install: post-install-plist
post-install-plist:
	@${SED} -e 's|$${TARGET_ARCH}|${TARGET_ARCH}|' \
		-e 's|$${EGCS_INTVERSION}|${EGCS_INTVERSION}|' \
		${PLIST_PRE} >${PLIST_SRC}
	@${ECHO} '@dirrm ${TARGET_ARCH}/bin' >>${PLIST_SRC}
	@${ECHO} '@exec mkdir -p ${TARGET_ARCH}/include' >>${PLIST_SRC}
	@${ECHO} '@dirrm ${TARGET_ARCH}/include' >>${PLIST_SRC}
	@${ECHO} '@exec mkdir -p ${TARGET_ARCH}/lib' >>${PLIST_SRC}
	@${ECHO} '@dirrm ${TARGET_ARCH}/lib' >>${PLIST_SRC}
	@${ECHO} '@dirrm ${TARGET_ARCH}' >>${PLIST_SRC}

.include "../../mk/bsd.pkg.mk"

EXTRACT_BEFORE_ARGS:=	-X ${COMMON_DIR}/exclude ${EXTRACT_BEFORE_ARGS}
