# $NetBSD: buildlink3.mk,v 1.13 2007/01/13 18:26:54 joerg Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
QT2_LIBS_BUILDLINK3_MK:=	${QT2_LIBS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	qt2-libs
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nqt2-libs}
BUILDLINK_PACKAGES+=	qt2-libs
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}qt2-libs

.if !empty(QT2_LIBS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.qt2-libs+=	qt2-libs>=2.3.1nb2
BUILDLINK_ABI_DEPENDS.qt2-libs+=	qt2-libs>=2.3.1nb9
BUILDLINK_PKGSRCDIR.qt2-libs?=	../../x11/qt2-libs
BUILDLINK_INCDIRS.qt2-libs=	qt2/include
BUILDLINK_LIBDIRS.qt2-libs=	qt2/lib
.endif	# QT2_LIBS_BUILDLINK3_MK

.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/MesaLib/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/mng/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libXext/buildlink3.mk"
.include "../../x11/libXft/buildlink3.mk"
.include "../../x11/libXmu/buildlink3.mk"
.include "../../x11/xextproto/buildlink3.mk"

QTDIR=		${BUILDLINK_PREFIX.qt2-libs}/qt2
CONFIGURE_ENV+=	QTDIR=${QTDIR:Q}
CONFIGURE_ENV+=	MOC="${QTDIR}/bin/moc"
MAKE_ENV+=	QTDIR=${QTDIR:Q}
MAKE_ENV+=	MOC="${QTDIR}/bin/moc"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
