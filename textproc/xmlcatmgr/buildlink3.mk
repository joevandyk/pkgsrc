# $NetBSD: buildlink3.mk,v 1.9 2006/07/08 23:11:11 jlam Exp $
#
# This Makefile fragment is included by packages that use xmlcatmgr.
#
# The following variables are automatically defined for free use in packages:
#    XMLCATMGR            - Path to the xmlcatmgr program.
#    SGML_DEFAULT_CATALOG - Path to the system-wide (tunable) SGML catalog.
#    XML_DEFAULT_CATALOG  - Path to the system-wide (tunable) XML catalog.
#
# Packages that recognize a system-wide catalog file should be configured
# to use SGML_DEFAULT_CATALOG or XML_DEFAULT_CATALOG, depending on the
# type of tool they are.
#

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
XMLCATMGR_BUILDLINK3_MK:=	${XMLCATMGR_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	xmlcatmgr
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nxmlcatmgr}
BUILDLINK_PACKAGES+=	xmlcatmgr
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}xmlcatmgr

.if !empty(XMLCATMGR_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.xmlcatmgr+=		xmlcatmgr>=2.0beta1
BUILDLINK_PKGSRCDIR.xmlcatmgr?=		../../textproc/xmlcatmgr

# Location of the xmlcatmgr binary program.
EVAL_PREFIX+=			XMLCATMGR_PREFIX=xmlcatmgr
XMLCATMGR_PREFIX_DEFAULT=	${LOCALBASE}
XMLCATMGR=			${XMLCATMGR_PREFIX}/bin/xmlcatmgr

# System-wide configurable catalogs.
.if defined(PKG_SYSCONFDIR.xmlcatmgr) && !empty(PKG_SYSCONFDIR.xmlcatmgr)
SGML_DEFAULT_CATALOG=	${PKG_SYSCONFDIR.xmlcatmgr}/sgml/catalog
XML_DEFAULT_CATALOG=	${PKG_SYSCONFDIR.xmlcatmgr}/xml/catalog
.else
SGML_DEFAULT_CATALOG=	${PKG_SYSCONFBASEDIR}/sgml/catalog
XML_DEFAULT_CATALOG=	${PKG_SYSCONFBASEDIR}/xml/catalog
.endif

PRINT_PLIST_AWK+=	/^@dirrm share\/(sgml|xml)$$/ \
				{ print "@comment in xmlcatmgr: " $$0; next }

.endif	# XMLCATMGR_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
