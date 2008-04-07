# $NetBSD: buildlink3.mk,v 1.9 2007/01/11 16:18:37 joerg Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
TK_BUILDLINK3_MK:=	${TK_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	tk
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ntk}
BUILDLINK_PACKAGES+=	tk
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}tk

.if !empty(TK_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.tk+=		tk-8.3.4*
BUILDLINK_ABI_DEPENDS.tk?=	tk>=8.3.4nb2
BUILDLINK_PKGSRCDIR.tk?=	../../x11/tk83

BUILDLINK_FILES.tk=	bin/wish*
#
# Make "-ltk" resolve into "-ltk83", so that we don't need to patch so
# many Makefiles.
#
BUILDLINK_TRANSFORM+=	l:tk:tk83
.endif	# TK_BUILDLINK3_MK

TKCONFIG_SH?=	${BUILDLINK_PREFIX.tk}/lib/tkConfig.sh

.include "../../lang/tcl83/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
