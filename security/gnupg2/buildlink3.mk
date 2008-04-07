# $NetBSD: buildlink3.mk,v 1.3 2007/11/08 21:06:33 bjs Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
GNUPG2_BUILDLINK3_MK:=	${GNUPG2_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	gnupg2
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Ngnupg2}
BUILDLINK_PACKAGES+=	gnupg2
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}gnupg2

.if ${GNUPG2_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.gnupg2+=	gnupg2>=2.0.0
BUILDLINK_PKGSRCDIR.gnupg2?=	../../security/gnupg2
BUILDLINK_PREFIX.gnupg2?=	${LOCALBASE}

pkgbase:=	gnupg2
.include "../../mk/pkg-build-options.mk"

.   if !empty(PKG_BUILD_OPTIONS.gnupg2:Midea)
pkgbase:=	libgcrypt
.   	include "../../mk/pkg-build-options.mk"
.   	if empty(PKG_BUILD_OPTIONS.libgcrypt:Midea)
PKGSRC_MAKE_ENV+=	PKG_OPTIONS.libgcrypt+=idea
.   	endif
.   endif
.endif	# GNUPG2_BUILDLINK3_MK

.include "../../security/libgpg-error/buildlink3.mk"
.include "../../security/libgcrypt/buildlink3.mk"
.include "../../security/libksba/buildlink3.mk"
.include "../../security/pinentry/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
