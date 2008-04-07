# $NetBSD: destdir.mk,v 1.2 2007/02/06 19:47:13 rillig Exp $
#
# ===
# Warning: This file is still under construction. Don't rely on it.
# ===
#
# This file documents the variables around the DESTDIR support.
#
# Normally, packages are installed directly into LOCALBASE and may
# overwrite files of other packages there. It also makes it easy to
# create packages which behave differently depending on whether they
# are installed from source or from a binary package. This is not good.
#
# The DESTDIR support tries to prevent some of these problems. When it
# is enabled, packages are not installed directly into LOCALBASE.
# Instead, they are installed in a temporary directory, and a binary
# package is created from the files that have been installed there.
#
# === User-settable variables ===
#
# USE_DESTDIR
#	* "yes" to enable DESTDIR support for those packages that
#	  explicitly support it.
#
#	* "full": This makes the build completely unprivileged and in
#	  turn detects any attempt to write e.g. to ${LOCALBASE}.
#	  This is not supported for actual installation yet, due to
#	  short comings of pkg_create. [FIXME]
#
# === Package-settable variables ===
#
# PKG_DESTDIR_SUPPORT
#	* "user-destdir" means that all files of the packages should be
#	  installed with default ownership and permissions.
#
#	* "destdir" means that some of the installed files need special
#	  ownership or permissions. The installation is done by the
#	  privileged user.
#
# === Implementation notes ===
#
# In the "install" phase, the variable DESTDIR is set in the make(1)
# environment of the default "do-install" target. Additionally, the
# variable is passed in the INSTALL_MAKE_FLAGS to override potential
# "DESTDIR=" entries in the Makefiles.
#
# Keywords: destdir
