# $NetBSD: env.mk,v 1.3 2007/03/01 18:30:11 wiz Exp $
#
# This file describes the *_ENV variables, where they are defined and
# where they are used.
#
# In general, all environments should be ordered from general to specific
# ones. That is, first comes the BARRIER_ENV, then the MAKE_ENV, then the
# MAKE_BUILD_ENV.
#
# Additionally, the package should be able to override all settings from
# the infrastructure. That means that the package-settable variables
# must appear behind the system-defined ones.
#

# XXX: I'm missing BARRIER_ENV or something like that.

# XXX: The do-* targets are not run with ALL_ENV (or better:
# BARRIER_ENV) in effect.

#
# Common environments.
#

# PKGSRC_MAKE_ENV
#

# ALL_ENV
#	This is the basic environment for the configure, build and install
#	phases. It can be overridden by CONFIGURE_ENV and MAKE_ENV.
#

#
# Environments for individual phases.
#

# EXTRACT_ENV

# CONFIGURE_ENV

# MAKE_ENV

# BSD_MAKE_ENV
#	This environment can be appended to MAKE_ENV by a package to
#	support packages using BSD-style Makefiles, for example
#	<bsd.prog.mk>.
#

# INSTALL_ENV
#	This environment is prepended to MAKE_ENV in the install phase.
#	XXX: Shouldn't this be _ap_pended?

#
# Other environments.
#

# INSTALL_SCRIPTS_ENV
#	TODO
#
