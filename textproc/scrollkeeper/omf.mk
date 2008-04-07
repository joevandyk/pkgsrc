# $NetBSD: omf.mk,v 1.14 2007/11/12 20:41:18 drochner Exp $
#
# This Makefile fragment is intended to be included by packages that install
# OMF files.  It takes care of registering them in scrollkeeper's global
# database.
#
# The following variables are automatically defined for free use in packages:
#    SCROLLKEEPER_DATADIR   - scrollkeeper's data directory.
#    SCROLLKEEPER_REBUILDDB - scrollkeeper-rebuilddb binary program.
#    SCROLLKEEPER_UPDATEDB  - scrollkeeper-update binary program.
#

.if !defined(SCROLLKEEPER_OMF_MK)
SCROLLKEEPER_OMF_MK=	# defined

.include "../../mk/bsd.prefs.mk"

# scrollkeeper's data directory.
SCROLLKEEPER_DATADIR=	${BUILDLINK_PREFIX.rarian}/libdata/scrollkeeper

# scrollkeeper binary programs.
SCROLLKEEPER_REBUILDDB=	${BUILDLINK_PREFIX.rarian}/bin/scrollkeeper-rebuilddb
SCROLLKEEPER_UPDATEDB=	${BUILDLINK_PREFIX.rarian}/bin/scrollkeeper-update

INSTALL_TEMPLATES+= \
 ${.CURDIR}/../../textproc/rarian/files/install-scrollkeeper.tmpl
DEINSTALL_TEMPLATES+= \
 ${.CURDIR}/../../textproc/rarian/files/install-scrollkeeper.tmpl

FILES_SUBST+=		SCROLLKEEPER_DATADIR=${SCROLLKEEPER_DATADIR:Q}
FILES_SUBST+=		SCROLLKEEPER_REBUILDDB=${SCROLLKEEPER_REBUILDDB:Q}
FILES_SUBST+=		SCROLLKEEPER_UPDATEDB=${SCROLLKEEPER_UPDATEDB:Q}

PRINT_PLIST_AWK+=	/^@dirrm share\/omf$$/ \
				{ print "@comment in rarian: " $$0; \
				  next; }

.include "../../textproc/rarian/buildlink3.mk"

.endif	# SCROLLKEEPER_OMF_MK
