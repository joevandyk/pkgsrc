# $NetBSD: buildlink3.mk,v 1.14 2007/09/21 13:04:00 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GOFFICE_BUILDLINK3_MK:=	${GOFFICE_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	goffice
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngoffice}
BUILDLINK_PACKAGES+=	goffice
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}goffice

.if ${GOFFICE_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.goffice+=	goffice>=0.4.0
BUILDLINK_ABI_DEPENDS.goffice?=	goffice>=0.4.0nb1
BUILDLINK_PKGSRCDIR.goffice?=	../../misc/goffice
.endif	# GOFFICE_BUILDLINK3_MK

PRINT_PLIST_AWK+=       /^@dirrm lib\/goffice\/0.4.0\/plugins$$/ \
				{ print "@comment in goffice: " $$0; \
				  next; }

.include "../../converters/libiconv/buildlink3.mk"
.include "../../devel/GConf/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libglade/buildlink3.mk"
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../devel/libgsf/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../devel/pcre/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../graphics/libart/buildlink3.mk"
.include "../../print/libgnomeprint/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
