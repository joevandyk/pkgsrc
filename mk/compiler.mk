# $NetBSD: compiler.mk,v 1.64 2007/10/17 10:43:37 rillig Exp $
#
# This Makefile fragment implements handling for supported C/C++/Fortran
# compilers.
#
# The following variables may be set by the pkgsrc user in mk.conf:
#
# PKGSRC_COMPILER
#	A list of values specifying the chain of compilers to be used by
#	pkgsrc to build packages.
#
#	Valid values are:
#		ccc		Compaq C Compilers (Tru64)
#		ccache		compiler cache (chainable)
#		distcc		distributed C/C++ (chainable)
#		f2c		Fortran 77 to C compiler (chainable)
#		icc		Intel C++ Compiler (Linux)
#		ido		SGI IRIS Development Option cc (IRIX 5)
#		gcc		GNU
#		hp		HP-UX C/aC++ compilers
#		mipspro		Silicon Graphics, Inc. MIPSpro (n32/n64)
#		mipspro-ucode	Silicon Graphics, Inc. MIPSpro (o32)
#		pcc		Portable C Compiler
#		sunpro		Sun Microsystems, Inc. WorkShip/Forte/Sun
#				ONE Studio
#		xlc		IBM's XL C/C++ compiler suite (Darwin/MacOSX)
#
#	The default is "gcc".  You can use ccache and/or distcc with
#	an appropriate PKGSRC_COMPILER setting, e.g. "ccache distcc
#	gcc".  You can also use "f2c" to overlay the lang/f2c package
#	over the C compiler instead of using the system Fortran
#	compiler.  The chain should always end in a real compiler.
#	This should only be set in /etc/mk.conf.
#
# USE_PKGSRC_GCC
#	Force using the appropriate version of GCC from pkgsrc based on
#	GCC_REQD instead of the native compiler.
#
# The following variables may be set by a package:
#
# GCC_REQD
#	A list of version numbers used to determine the minimum
#	version of GCC required by a package.  This value should only
#	be appended to by a package Makefile.
#
#	NOTE: Be conservative when setting GCC_REQD, as lang/gcc3 is
#	known not to build on some platforms, e.g. Darwin.  If gcc3 is
#	required, set GCC_REQD=3.0 so that we do not try to pull in
#	lang/gcc3 unnecessarily and have it fail.
#
# USE_LANGUAGES
#	Lists the languages used in the source code of the package,
#	and is used to determine the correct compilers to install.
#	Valid values are: c, c99, c++, fortran, java, objc.  The
#       default is "c".
#
# The following variables are defined, and available for testing in
# package Makefiles:
#
# CC_VERSION
#	The compiler and version being used, e.g.,
#
#	.include "../../mk/compiler.mk"
#
#	.if !empty(CC_VERSION:Mgcc-3*)
#	...
#	.endif
#

.if !defined(BSD_COMPILER_MK)
BSD_COMPILER_MK=	defined

_VARGROUPS+=		compiler
_USER_VARS.compiler=	PKGSRC_COMPILER USE_PKGSRC_GCC ABI
_PKG_VARS.compiler=	USE_LANGUAGES GCC_REQD NOT_FOR_COMPILER ONLY_FOR_COMPILER
_SYS_VARS.compiler=	CC_VERSION

.include "bsd.fast.prefs.mk"

# Since most packages need a C compiler, this is the default value.
USE_LANGUAGES?=	c

# Add c support if c99 is set
.if !empty(USE_LANGUAGES:Mc99)
USE_LANGUAGES+=	c
.endif

# For environments where there is an external gcc too, but pkgsrc
# should use the pkgsrc one for consistency.
#
.if defined(USE_PKGSRC_GCC)
_USE_PKGSRC_GCC=	yes
.endif

_COMPILERS=		ccc gcc icc ido mipspro mipspro-ucode sunpro xlc hp pcc
_PSEUDO_COMPILERS=	ccache distcc f2c

.if defined(NOT_FOR_COMPILER) && !empty(NOT_FOR_COMPILER)
.  for _compiler_ in ${_COMPILERS}
.    if ${NOT_FOR_COMPILER:M${_compiler_}} == ""
_ACCEPTABLE_COMPILERS+=	${_compiler_}
.    endif
.  endfor
.elif defined(ONLY_FOR_COMPILER) && !empty(ONLY_FOR_COMPILER)
.  for _compiler_ in ${_COMPILERS}
.    if ${ONLY_FOR_COMPILER:M${_compiler_}} != ""
_ACCEPTABLE_COMPILERS+=	${_compiler_}
.    endif
.  endfor
.else
_ACCEPTABLE_COMPILERS+=	${_COMPILERS}
.endif

.if defined(_ACCEPTABLE_COMPILERS)
.  for _acceptable_ in ${_ACCEPTABLE_COMPILERS}
.    for _compiler_ in ${PKGSRC_COMPILER}
.      if !empty(_ACCEPTABLE_COMPILERS:M${_compiler_}) && !defined(_COMPILER)
_COMPILER=	${_compiler_}
.      endif
.    endfor
.  endfor
.endif

.if !defined(_COMPILER)
PKG_FAIL_REASON+=	"No acceptable compiler found for ${PKGNAME}."
.endif

.for _compiler_ in ${PKGSRC_COMPILER}
.  if !empty(_PSEUDO_COMPILERS:M${_compiler_})
_PKGSRC_COMPILER:=	${_compiler_} ${_PKGSRC_COMPILER}
.  endif
.endfor
_PKGSRC_COMPILER:=	${_COMPILER} ${_PKGSRC_COMPILER}

_COMPILER_STRIP_VARS=	# empty

.for _compiler_ in ${_PKGSRC_COMPILER}
.  include "compiler/${_compiler_}.mk"
.endfor
.undef _compiler_

.if !defined(PKG_CPP)
PKG_CPP:=${CPP}
.endif

# Strip the leading paths from the toolchain variables since we manipulate
# the PATH to use the correct executable.
#
.for _var_ in ${_COMPILER_STRIP_VARS}
.  if empty(${_var_}:C/^/_asdf_/1:N_asdf_*)
${_var_}:=	${${_var_}:C/^/_asdf_/1:M_asdf_*:S/^_asdf_//:T}
.  else
${_var_}:=	${${_var_}:C/^/_asdf_/1:M_asdf_*:S/^_asdf_//:T} ${${_var_}:C/^/_asdf_/1:N_asdf_*}
.  endif
.endfor

.if defined(ABI) && !empty(ABI)
_WRAP_EXTRA_ARGS.CC+=	${_COMPILER_ABI_FLAG.${ABI}}
_WRAP_EXTRA_ARGS.CXX+=	${_COMPILER_ABI_FLAG.${ABI}}
_WRAP_EXTRA_ARGS.LD+=	${_LINKER_ABI_FLAG.${ABI}}
.endif

# If the languages are not requested, force them not to be available
# in the generated wrappers.
#
_FAIL_WRAPPER.CC=	${WRKDIR}/.compiler/bin/c-fail-wrapper
_FAIL_WRAPPER.CXX=	${WRKDIR}/.compiler/bin/c++-fail-wrapper
_FAIL_WRAPPER.FC=	${WRKDIR}/.compiler/bin/fortran-fail-wrapper

${_FAIL_WRAPPER.CC}: fail-wrapper
${_FAIL_WRAPPER.CXX}: fail-wrapper
${_FAIL_WRAPPER.FC}: fail-wrapper

.PHONY: fail-wrapper
fail-wrapper: .USE
	${_PKG_SILENT}${_PKG_DEBUG}${MKDIR} ${.TARGET:H}
	${_PKG_SILENT}${_PKG_DEBUG}					\
	exec 1>${.TARGET};						\
	${ECHO} '#!'${TOOLS_SHELL:Q};					\
	${ECHO} 'wrapperlog="$${TOOLS_WRAPPER_LOG-'${_TOOLS_WRAP_LOG:Q}'}"'; \
	${ECHO} 'lang="${.TARGET:T:S/-fail-wrapper//}"'; \
	${ECHO} 'msg="*** Please consider adding $$lang to USE_LANGUAGES in the package Makefile."'; \
	${ECHO} '${ECHO} "$$msg" >> $$wrapperlog'; \
	${ECHO} '${ECHO} "$$msg" > ${WARNING_DIR}/${.TARGET:T}'; \
	${ECHO} '${ECHO} "ERROR: To use this compiler, you have to add $$lang to" 1>&2'; \
	${ECHO} '${ECHO} "ERROR: USE_LANGUAGES in the package Makefile." 1>&2'; \
	${ECHO} 'exit 1'
	${_PKG_SILENT}${_PKG_DEBUG}${CHMOD} +x ${.TARGET}

.if empty(USE_LANGUAGES:Mc) && empty(USE_LANGUAGES:Mobjc)
PKG_CC:=		${_FAIL_WRAPPER.CC}
ALL_ENV+=		CPP=${CPP:Q}
override-tools: ${_FAIL_WRAPPER.CC}
.endif
.if empty(USE_LANGUAGES:Mc++)
PKG_CXX:=		${_FAIL_WRAPPER.CXX}
ALL_ENV+=		CXXCPP=${CPP:Q} # to make some Autoconf scripts happy
override-tools: ${_FAIL_WRAPPER.CXX}
.endif
.if empty(USE_LANGUAGES:Mfortran)
PKG_FC:=		${_FAIL_WRAPPER.FC}
override-tools: ${_FAIL_WRAPPER.FC}
.endif

.endif	# BSD_COMPILER_MK
