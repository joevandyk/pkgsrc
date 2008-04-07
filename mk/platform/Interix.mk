# $NetBSD: Interix.mk,v 1.54 2007/10/19 13:41:35 rillig Exp $
#
# Variable definitions for the Interix operating system.

# SHLIB BASE ADDRESSES:
#
# [tv] For reference, here's a list of shared library base address ranges used
# throughout pkgsrc to cope with the fact that Interix has no proper PIC
# support in the compiler.  This list will be kept updated for any new packages
# also needing special handling.
#
# Fortunately, libtool covers most of this, and uses a randomized base address
# selection as described below.  This randomized base address concept is used
# again in a couple other places.
#
# * = currently uses fixed default of 0x10000000 and needs something better
#     (this base address restricts how far sbrk() can go in memory, and of
#     course, collides with everything else, requiring runtime text relocs)
#
# pkg		start		end		slotsize	#slots
#
# <bsd.lib.mk>	0x50000000	0x6fffffff	0x00040000	2048
# libtool-base	0x50000000	0x6fffffff	0x00040000	2048
# netpbm	0x6b000000	0x6cffffff	0x00100000	32
# openssl	0x5e000000	0x5fffffff	0x00100000	32
# perl5		*
# python22	*
# python23	*
# python24	*
# ruby16	0x50000000	0x6fffffff	0x00040000	2048
#   (main lib)	0x48000000
# ruby18	0x50000000	0x6fffffff	0x00040000	2048
#   (main lib)	0x48000000
# zsh		*

# ADDITIONAL NOTES:
#
# * It appears that www/curl 1.15.0+ has support for SIOCGIFADDR via
#   an undocumented ioctl interface.  It may be worthwhile to look at
#   adding that hack into a more proper <net/if.h> to be supplied by
#   pkgsrc's compiler wrappers.  [tv]

###
### Overrides to standard BSD .mk files
###

# "catinstall" not yet supported as there's no shipped [gn]roff
MANINSTALL=	maninstall
MAKE_FLAGS+=	MKCATPAGES=no NOLINT=1

###
### Alternate defaults to global pkgsrc settings, to help avoid
### some of the excessive Interix fork(2) overhead, and reduce the
### amount of settings required in the user's mk.conf
###

# NetBSD's faster, vfork-capable shell (not yet in pkgsrc)
#BULK_PREREQ+=		shells/nbsh
.if exists(${PREFIX}/bin/nbsh)
TOOLS_SHELL?=		${PREFIX}/bin/nbsh
WRAPPER_SHELL?=		${PREFIX}/bin/nbsh
.endif

INSTALL?=		${PREFIX}/bin/install-sh
PAX?=			${PREFIX}/bin/pax
SED?=			${PREFIX}/bin/nbsed

GCC_USE_SYMLINKS?=	yes
WRAPPER_DEBUG?=		no

.if defined(BATCH)
BULK_PREREQ+=		lang/perl5
USE_BULK_BROKEN_CHECK?=	no
USE_BULK_TIMESTAMPS?=	no
.endif

###
### Platform definitions common to pkgsrc/mk/platform/*.mk
###

ECHO_N?=	/bin/printf %s			# does not support "echo -n"
IMAKE_MAKE?=	${MAKE}		# program which gets invoked by imake
IMAKEOPTS+=	-DBuildHtmlManPages=NO
PKGLOCALEDIR?=	share
PS?=		/bin/ps
SU?=		/bin/su
TYPE?=		type				# Shell builtin

USERADD?=		${LOCALBASE}/sbin/useradd
GROUPADD?=		${LOCALBASE}/sbin/groupadd
_PKG_USER_HOME?=	# empty by default
_USER_DEPENDS=		user>=20040426:../../sysutils/user_interix

CPP_PRECOMP_FLAGS?=	# unset
CONFIG_RPATH_OVERRIDE?=	config.rpath */config.rpath */*/config.rpath
DEF_UMASK?=		002
EXPORT_SYMBOLS_LDFLAGS?=-Wl,-E	# add symbols to the dynamic symbol table

MOTIF_TYPE_DEFAULT?=	openmotif	# default 2.0 compatible libs type
NOLOGIN?=		/bin/false
PKG_TOOLS_BIN?=		${LOCALBASE}/sbin
PKGDIRMODE?=		775
# ROOT_USER might be numeric in the special case of Administrator; canonify it:
ROOT_CMD?=		${SU} - "$$(id -un ${ROOT_USER})" -c
ROOT_USER?=		${BINOWN}
ROOT_GROUP?=		131616 # +Administrators or native language equivalent
TOUCH_FLAGS?=
ULIMIT_CMD_datasize?=	ulimit -d `ulimit -H -d`
ULIMIT_CMD_stacksize?=	ulimit -s `ulimit -H -s`
ULIMIT_CMD_memorysize?=	ulimit -v `ulimit -H -v`

# imake installs manpages in weird places
IMAKE_MAN_SOURCE_PATH=	man/man
IMAKE_MAN_SUFFIX=	n
IMAKE_LIBMAN_SUFFIX=	3
IMAKE_KERNMAN_SUFFIX=	4
IMAKE_FILEMAN_SUFFIX=	5
IMAKE_GAMEMAN_SUFFIX=	6
IMAKE_MISCMAN_SUFFIX=	7
IMAKE_MAN_DIR=		${IMAKE_MAN_SOURCE_PATH}n
IMAKE_LIBMAN_DIR=	${IMAKE_MAN_SOURCE_PATH}3
IMAKE_KERNMAN_DIR=	${IMAKE_MAN_SOURCE_PATH}4
IMAKE_FILEMAN_DIR=	${IMAKE_MAN_SOURCE_PATH}5
IMAKE_GAMEMAN_DIR=	${IMAKE_MAN_SOURCE_PATH}6
IMAKE_MISCMAN_DIR=	${IMAKE_MAN_SOURCE_PATH}7
IMAKE_MANNEWSUFFIX=	${IMAKE_MAN_SUFFIX}
IMAKE_MANINSTALL?=	maninstall catinstall

.if exists(/usr/include/netinet6)
_OPSYS_HAS_INET6=	yes	# IPv6 is standard
.else
_OPSYS_HAS_INET6=	no	# IPv6 is not standard
.endif
_OPSYS_HAS_JAVA=	no	# Java is not standard
_OPSYS_HAS_MANZ=	yes	# MANZ controls gzipping of man pages
_OPSYS_HAS_OSSAUDIO=	no	# libossaudio is available
_OPSYS_LIBTOOL_REQD=	1.5.18nb6
_OPSYS_PERL_REQD=	5.8.3nb1 # base version of perl required
_OPSYS_PTHREAD_AUTO=	no	# -lpthread needed for pthreads
_OPSYS_SHLIB_TYPE=	ELF	# shared lib type - not exactly true, but near enough
_PATCH_CAN_BACKUP=	yes	# native patch(1) can make backups
_PATCH_BACKUP_ARG?=	-b -V simple -z	# switch to patch(1) for backup suffix
_USE_RPATH=		yes	# add rpath to LDFLAGS

# Ensure that USE_X11BASE programs get an xpkgwedge new enough to work.
_OPSYS_NEEDS_XPKGWEDGE=	yes	# xpkgwedge is required for X11
_XPKGWEDGE_DEPENDS=	xpkgwedge>=1.10:../../pkgtools/xpkgwedge
BUILD_DEPENDS+=		${USE_X11BASE:D${_XPKGWEDGE_DEPENDS}}

# flags passed to the linker to extract all symbols from static archives.
# this is GNU ld.
_OPSYS_WHOLE_ARCHIVE_FLAG=	-Wl,--whole-archive
_OPSYS_NO_WHOLE_ARCHIVE_FLAG=	-Wl,--no-whole-archive

_STRIPFLAG_CC?=		${_INSTALL_UNSTRIPPED:D:U-s}	# cc(1) option to strip
_STRIPFLAG_INSTALL?=	${_INSTALL_UNSTRIPPED:D:U-s}	# install(1) option to strip

DEFAULT_SERIAL_DEVICE?=	/dev/tty00
SERIAL_DEVICES?=	/dev/tty00 /dev/tty01 /dev/tty02 /dev/tty03

# poll(2) is broken; try to work around it by making autoconf believe
# it's missing.  (Packages without autoconf will need explicit fixing.)
CONFIGURE_ENV+=		${GNU_CONFIGURE:Dac_cv_header_poll_h=no ac_cv_func_poll=no}

# Interix has a hstrerror(3), but it's a macro, not a function.
CONFIGURE_ENV+=		${GNU_CONFIGURE:Dac_cv_func_hstrerror=yes}

# check for maximum command line length and set it in configure's environment,
# to avoid a test required by the libtool script that takes forever.
_OPSYS_MAX_CMDLEN_CMD=	${ECHO} 262144

# If games are to be installed setgid, then SETGIDGAME is set to 'yes'
# (it defaults to 'no' as per defaults/mk.conf).
# Set the group and mode to meaningful values in that case (defaults to
# BINOWN, BINGRP and BINMODE as per defaults/mk.conf).
# FIXME: Adjust to work on this system and enable the lines below.
#.if !(empty(SETGIDGAME:M[yY][eE][sS]))
#GAMEOWN=		games
#GAMEGRP=		games
#GAMEMODE=		2555
#GAMEDIRMODE=		0775
#.endif
