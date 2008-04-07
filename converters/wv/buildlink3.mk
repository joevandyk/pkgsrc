# $NetBSD: buildlink3.mk,v 1.16 2007/06/05 05:37:17 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
WV_BUILDLINK3_MK:=	${WV_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	wv
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nwv}
BUILDLINK_PACKAGES+=	wv
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}wv

.if !empty(WV_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.wv+=		wv>=1.0.0
BUILDLINK_ABI_DEPENDS.wv+=	wv>=1.2.4nb1
BUILDLINK_PKGSRCDIR.wv?=	../../converters/wv
.endif	# WV_BUILDLINK3_MK

.include "../../converters/libiconv/buildlink3.mk"
.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/libgsf/buildlink3.mk"
.include "../../graphics/libwmf/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
