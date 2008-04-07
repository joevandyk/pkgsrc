# $NetBSD: buildlink3.mk,v 1.19 2006/07/08 23:10:56 jlam Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
TCL_BUILDLINK3_MK:=	${TCL_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	tcl
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ntcl}
BUILDLINK_PACKAGES+=	tcl
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}tcl

.if !empty(TCL_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.tcl+=	tcl>=8.4.6nb1
BUILDLINK_ABI_DEPENDS.tcl+=	tcl>=8.4.7nb1
BUILDLINK_PKGSRCDIR.tcl?=	../../lang/tcl

BUILDLINK_FILES.tcl+=	bin/tclsh*
#
# Make "-ltcl" and "-ltcl8.4" resolve into "-ltcl84", so that we don't
# need to patch so many Makefiles.
#
BUILDLINK_TRANSFORM+=	l:tcl:tcl84
BUILDLINK_TRANSFORM+=	l:tcl8.4:tcl84

TCLCONFIG_SH?=		${BUILDLINK_PREFIX.tcl}/lib/tclConfig.sh

PRINT_PLIST_AWK+=	/^@dirrm lib\/tcl$$/ \
				{ print "@comment in tcl: " $$0; next; }
.endif	# TCL_BUILDLINK3_MK

.include "../../mk/dlopen.buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
