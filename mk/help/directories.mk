# $NetBSD: directories.mk,v 1.4 2007/01/17 12:47:21 rillig Exp $
#
# This file contains some short documentation on the directories that
# are used within pkgsrc.

# PREFIX
#	This is the directory where the package should install its
#	files. The actual value depends on the variables
#	PKG_INSTALLATION_TYPE, USE_X11BASE and USE_CROSSBASE.
#
#	Tags: read-only, system-defined, non-overridable, etc.
#
#	See also:
#		CROSSBASE,
#		INSTALLATION_PREFIX,
#		LOCALBASE,
#		X11PREFIX,
#		PKG_INSTALLATION_TYPE.
#

# LOCALBASE
#	This is the directory where all packages are usually installed.
#	It is set by the user, and packages must not modify it.
#

# PKG_SYSCONFBASE
# PKG_SYSCONFDIR.*
#	These variables may be set in mk.conf to control where the
#	configuration files are put.
#
#	See also: guide:faq.html#faq.conf
#

# PKG_SYSCONFVAR
#	This variable can be set by packages to select the variable
#	which can then be overridden in mk.conf to change the directory
#	where the configuration files go.
#
#	Default value: ${PKGBASE}
#

# PKG_SYSCONFDIR
#	This is the directory where the current package should install
#	its configuration files. It may be changed by the package to
#	point to a subdirectory of PKG_SYSCONFBASE.
#

# TODO:PKG_SYSCONFDEPOTBASE
# TODO:PKG_SYSCONFBASEDIR
#

# PKGDIR
#	The directory where the various files that define a package are
#	read from. These are:
#
#	* DESCR
#	* HEADER, HEADER_TEMPLATES
#	* INSTALL, DEINSTALL
#	* MESSAGE, MESSAGE.*
#	* PLIST, PLIST.*
#	* distinfo
#	* hacks.mk
#
#	Default value: the current directory.
#
#	Tags: package-settable
#

# WRKDIR
#	The base directory where all the work is done for building a
#	package. The pkgsrc infrastructure creates various files in this
#	directory, whose names all start with a dot.
#
#	The default value of EXTRACT_DIR is ${WRKDIR}.
#	The default value of WRKSRC is ${WRKDIR}/${DISTNAME}.
#
#	When PKGSRC_LOCKTYPE is set, a lock file is placed into this
#	directory to prevent multiple processes from trying to build
#	the package at the same time.
#
#	See also:
#		EXTRACT_DIR, WRKSRC, CREATE_WRKDIR_SYMLINK, WRKOBJDIR,
#		WRKDIR_BASENAME, OBJHOSTNAME, OBJMACHINE
#
#	Keywords: work
#
