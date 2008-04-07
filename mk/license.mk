# $NetBSD: license.mk,v 1.9 2007/11/08 19:31:05 joerg Exp $
#
# Note: This file is in draft state and not yet actively used.
#
# This file handles everything about the LICENSE variable. It is
# included automatically by bsd.pkg.mk.
#
# XXX: Some of this content arguably belongs in the pkgsrc guide
# instead.
#
# === User-settable variables ===
#
# ACCEPTABLE_LICENSES
#	If a package declares a license and that license is not a
#	member of the list defined by this variable, pkgsrc will
#	refuse to build the package.
#
#	XXX: pkg_install should also check LICENSE and decline to
#	install if it is not in ACCEPTABLE_LICENSES.
#
#	XXX: Perhaps there should be some mechanism to prevent running
#	programs that are part of packages that declare LICENSEs that
#	are not in ACCEPTABLE_LICENSES or some per-user variable.
#	This is surely controversial and requires discussion.
#
#	To include the default licenses, you can use the += operator
#	in mk.conf. To override it, use the plain = operator.
#
#	Default value: ${DEFAULT_ACCEPTABLE_LICENSES}
#
# === Package-settable variables ===
#
# LICENSE
#	The license of the package.
#
#	When the package has multiple licenses, there are many different
#	cases. Some packages use an OR-combination, while others use an
#	AND-combination. Currently, pkgsrc can only handle a single
#	license per package. For now, add a description of the licensing
#	to ../doc/TODO, section "Licenses of packages".  Note that in
#	such cases, one can place the text of both licenses in
#	licenses/foo-license and reference it.
#
#	Every package should specify its license.  (Prior to July 2007,
#	Open Source and Free software did not have license tags.)
#
#	Licenses are collected in the licenses/ subdirectory of
#	pkgsrc.  For open source license, we generally use the same
#	names as either the Open Source Initiative or the Free
#	Software Foundation, choosing a name to reduce confusion.
#	Open source and free licenses do not have a -license suffix,
#	and non-free licenses do.
#
#	http://opensource.org/licenses/category
#	http://www.fsf.org/licensing/licenses/index_html
#
# === Predefined variables ===
#
# DEFAULT_ACCEPTABLE_LICENSES
#	The list of licenses that will be the default value of
#	ACCEPTABLE_LICENSES.  Adapting the longstanding policy of Open
#	Source or Free licenses not requiring tags, it should contain
#	all licenses that are Open Source or Free, so as to provide
#	the most expansive default that almost all people find
#	acceptable.  (Many people will want to add more licenses to
#	ACCEPTABLE_LICENSES; the point is to have a default that very
#	few people want to shrink.)
#
# === See also ===
#
#	../doc/TODO, section "Licenses of packages"
#

# This list is not complete.  Free and Open Source licenses should be
# added to the list as they are added to pkgsrc.

# XXX Surely we will encounter licenses that clearly are Free, but
# which have not been formally approved.  These licenses, if added,
# should be somehow marked.

DEFAULT_ACCEPTABLE_LICENSES= \
	public-domain \
	gnu-gpl-v2 gnu-lgpl-v2 \
	gnu-gpl-v3 gnu-lgpl-v3 \
	original-bsd modified-bsd \
	x11 \
	apache-2.0 \
	cddl-1.0 \
	open-font-license

.if !defined(LICENSE)
.  if defined(AFTER_2007Q3)
LICENSE?=		unknown
PKG_FAIL_REASON+=	"[license.mk] Every package must define a LICENSE."
.  else
WARNINGS+=		"[license.mk] Every package should define a LICENSE."
.  endif

.else

# Note: some bulk builders rely on the fact that they can set
# _ACCEPTABLE to bypass license checks.  Inform them when you intend to
# remove this variable.
.  if defined(ACCEPTABLE_LICENSES) && !empty(ACCEPTABLE_LICENSES:M${LICENSE})
_ACCEPTABLE=	yes
.  endif

.  if !defined(_ACCEPTABLE)
PKG_FAIL_REASON+= "${PKGNAME} has an unacceptable license: ${LICENSE}." \
	 "    To view the license, enter \"${MAKE} show-license\"." \
	 "    To indicate acceptance, add this line to your mk.conf:" \
	 "    ACCEPTABLE_LICENSES+=${LICENSE}"
.  endif
.endif
