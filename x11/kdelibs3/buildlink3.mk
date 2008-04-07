# $NetBSD: buildlink3.mk,v 1.28 2007/11/30 21:55:01 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
KDELIBS_BUILDLINK3_MK:=	${KDELIBS_BUILDLINK3_MK}+

.include "../../mk/bsd.fast.prefs.mk"

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	kdelibs
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nkdelibs}
BUILDLINK_PACKAGES+=	kdelibs
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}kdelibs

.if !empty(KDELIBS_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.kdelibs+=	kdelibs>=3.5.6
BUILDLINK_ABI_DEPENDS.kdelibs?=	kdelibs>=3.5.8nb2
BUILDLINK_PKGSRCDIR.kdelibs?=	../../x11/kdelibs3
.endif	# KDELIBS_BUILDLINK3_MK

pkgbase := kdelibs
.include "../../mk/pkg-build-options.mk"

.if !empty(PKG_BUILD_OPTIONS.kdelibs:Mcups)
.  include "../../print/cups/buildlink3.mk"
.endif
.include "../../archivers/bzip2/buildlink3.mk"
.include "../../audio/arts/buildlink3.mk"
.include "../../audio/libaudiofile/buildlink3.mk"
.include "../../devel/libidn/buildlink3.mk"
.include "../../devel/pcre/buildlink3.mk"
.include "../../graphics/jasper/buildlink3.mk"
.include "../../graphics/jpeg/buildlink3.mk"
.include "../../graphics/libart/buildlink3.mk"
.include "../../graphics/openexr/buildlink3.mk"
.include "../../graphics/tiff/buildlink3.mk"
.include "../../net/mDNSResponder/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../textproc/aspell/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../textproc/libxslt/buildlink3.mk"
.include "../../x11/qt3-libs/buildlink3.mk"
.include "../../mk/krb5.buildlink3.mk"
.include "../../mk/oss.buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
