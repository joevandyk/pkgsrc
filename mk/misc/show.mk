# $NetBSD: show.mk,v 1.8 2007/10/16 21:33:00 wiz Exp $
#
# This file contains some targets that print information gathered from
# variables. They do not modify any variables.
#

# show-tools:
#	Emits a /bin/sh shell script that defines all known tools
#	to the values they have in the pkgsrc infrastructure.
#
show-tools: .PHONY
.for t in ${_USE_TOOLS}
.  if defined(_TOOLS_VARNAME.${t})
	@${ECHO} ${_TOOLS_VARNAME.${t}:Q}=${${_TOOLS_VARNAME.${t}}:Q:Q}
.  endif
.endfor

# show-build-defs:
#	Prints the variables that can be configured by the pkgsrc user
#	in mk.conf, and the effects that those settings have.
#

BUILD_DEFS?=		# none
BUILD_DEFS_EFFECTS?=	# none

.if !empty(PKGSRC_SHOW_BUILD_DEFS:M[yY][eE][sS])
pre-depends-hook: show-build-defs
.endif

show-build-defs: .PHONY
.if !empty(BUILD_DEFS:M*)
	@${ECHO} "=========================================================================="
	@${ECHO} "The following variables will affect the build process of this package,"
	@${ECHO} "${PKGNAME}.  Their current value is shown below:"
	@${ECHO} ""
.  for var in ${BUILD_DEFS:O}
.    if !defined(${var})
	@${ECHO} "        * ${var} (not defined)"
.    elif defined(${var}) && empty(${var})
	@${ECHO} "        * ${var} (defined)"
.    else
	@${ECHO} "        * ${var} = "${${var}:Q}
.    endif
.  endfor
.  if !empty(BUILD_DEFS_EFFECTS:M*)
	@${ECHO} ""
	@${ECHO} "Based on these variables, the following variables have been set:"
	@${ECHO} ""
.  endif
.  for var in ${BUILD_DEFS_EFFECTS:O}
.    if !defined(${var})
	@${ECHO} "        * ${var} (not defined)"
.    elif defined(${var}) && empty(${var})
	@${ECHO} "        * ${var} (defined, but empty)"
.    else
	@${ECHO} "        * ${var} = "${${var}:Q}
.    endif
.  endfor
	@${ECHO} ""
	@${ECHO} "You may want to abort the process now with CTRL-C and change their value"
	@${ECHO} "before continuing.  Be sure to run \`${MAKE} clean' after"
	@${ECHO} "the changes."
	@${ECHO} "=========================================================================="
.endif

# show-all:
#	Prints a list of (hopefully) all pkgsrc variables that are visible
#	to the user or the package developer. It is intended to give
#	interested parties a better insight into the inner workings of
#	pkgsrc. Each variable name is prefixed with a "category":
#
#		* "usr" for user-settable variables,
#		* "pkg" for package-settable variables,
#		* "sys" for system-defined variables.
#
# Keywords: debug show _vargroups
#

# The following types of variables are categorized:
#
# _USER_VARS.*
#	Variables that can be set by the user and whose primary file is
#	this file.
#
# _PKG_VARS.*
#	Variables that can be set by the package and whose primary file
#	is this file.
#
# _SYS_VARS.*
#	Variables that are defined by this file and that are intended to
#	be used by packages.
#
# _DEF_VARS.*
#	All variables that are defined by this file, whether internal or
#	not, primary or not.
#
# _USE_VARS.*
#	All variables that are used by this file, whether internal or
#	not, primary or not.
#
_SHOW_ALL_CATEGORIES=	_USER_VARS _PKG_VARS _SYS_VARS _USE_VARS _DEF_VARS
_LABEL._USER_VARS=	usr
_LABEL._PKG_VARS=	pkg
_LABEL._SYS_VARS=	sys
_LABEL._USE_VARS=	use
_LABEL._DEF_VARS=	def

show-all: .PHONY
.for g in ${_VARGROUPS:O:u}

show-all: show-all-${g}

show-all-${g}: .PHONY
	@echo "${g}:"
.  for c in ${_SHOW_ALL_CATEGORIES}
.    for v in ${${c}.${g}}
.      if defined(${v})
# Be careful not to evaluate variables too early. Some may use the :sh
# modifier, which can end up taking much time and issuing unexpected
# warnings and error messages.
#
# When finally showing the variables, it is unavoidable that those
# variables requiring ${WRKDIR} to exist will show a warning.
#
	@value=${${v}:M*:Q};						\
	if [ "$$value" ]; then						\
	  echo "  ${_LABEL.${c}}	${v} = $$value";		\
	else								\
	  echo "  ${_LABEL.${c}}	${v} (defined, but empty)";	\
	fi
.      else
	@echo "  ${_LABEL.${c}}	${v} (undefined)"
.      endif
.    endfor
.  endfor
	@echo ""
.endfor
