# $NetBSD: buildlink3.mk,v 1.11 2007/08/08 03:23:20 wulf Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
GNURADIO_WXGUI_BUILDLINK3_MK:=	${GNURADIO_WXGUI_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	gnuradio-wxgui
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnuradio-wxgui}
BUILDLINK_PACKAGES+=	gnuradio-wxgui
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gnuradio-wxgui

.if ${GNURADIO_WXGUI_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.gnuradio-wxgui+=	gnuradio-wxgui>=3.0.4
BUILDLINK_PKGSRCDIR.gnuradio-wxgui?=	../../ham/gnuradio-wxgui
.endif	# GNURADIO_WXGUI_BUILDLINK3_MK

.include "../../ham/gnuradio-core/buildlink3.mk"
.include "../../x11/py-wxWidgets/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
