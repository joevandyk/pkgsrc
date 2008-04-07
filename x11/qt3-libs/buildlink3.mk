# $NetBSD: buildlink3.mk,v 1.21 2007/01/15 16:19:43 joerg Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
QT3_LIBS_BUILDLINK3_MK:=	${QT3_LIBS_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	qt3-libs
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nqt3-libs}
BUILDLINK_PACKAGES+=	qt3-libs
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}qt3-libs

.if !empty(QT3_LIBS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.qt3-libs+=	qt3-libs>=3.2.3
BUILDLINK_ABI_DEPENDS.qt3-libs?=	qt3-libs>=3.3.6nb1
BUILDLINK_PKGSRCDIR.qt3-libs?=	../../x11/qt3-libs

BUILDLINK_INCDIRS.qt3-libs+=	qt3/include
BUILDLINK_LIBDIRS.qt3-libs+=	qt3/lib
.endif	# QT3_LIBS_BUILDLINK3_MK

QTDIR=	${BUILDLINK_PREFIX.qt3-libs}/qt3
BUILDLINK_PASSTHRU_DIRS+=	${QTDIR}

.include "../../mk/bsd.fast.prefs.mk"

PTHREAD_OPTS+=	require

.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/MesaLib/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
.include "../../graphics/mng/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../x11/libSM/buildlink3.mk"
.include "../../x11/libXcursor/buildlink3.mk"
.include "../../x11/libXft/buildlink3.mk"
.include "../../x11/libXmu/buildlink3.mk"
.include "../../x11/libXrandr/buildlink3.mk"
.if ${X11_TYPE} == "modular"
.include "../../x11/libXinerama/buildlink3.mk"
.endif
.include "../../mk/pthread.buildlink3.mk"

CONFIGURE_ENV+=		MOC="${QTDIR}/bin/moc"
MAKE_ENV+=		MOC="${QTDIR}/bin/moc"
#LDFLAGS+=		${COMPILER_RPATH_FLAG}${QTDIR}/lib

.if !defined(BUILD_QT3)
CONFIGURE_ENV+=		QTDIR=${QTDIR:Q}
MAKE_ENV+=		QTDIR=${QTDIR:Q}
.endif

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
