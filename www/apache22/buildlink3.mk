# $NetBSD: buildlink3.mk,v 1.3 2007/06/08 12:25:06 wiz Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
APACHE_BUILDLINK3_MK:=	${APACHE_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	apache
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Napache}
BUILDLINK_PACKAGES+=	apache
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}apache

.if !empty(APACHE_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.apache+=	apache>=2.2.3
BUILDLINK_ABI_DEPENDS.apache?=	apache>=2.2.4nb5
BUILDLINK_PKGSRCDIR.apache?=	../../www/apache22
BUILDLINK_DEPMETHOD.apache?=	build
.  if defined(APACHE_MODULE)
BUILDLINK_DEPMETHOD.apache+=	full
.  endif
USE_TOOLS+=	perl			# for "apxs"
CONFIGURE_ENV+=	APR_LIBTOOL=${LIBTOOL:Q}	# make apxs use the libtool we specify
MAKE_ENV+=	APR_LIBTOOL=${LIBTOOL:Q}
APXS?=		${BUILDLINK_PREFIX.apache}/sbin/apxs
.  if defined(GNU_CONFIGURE)
CONFIGURE_ARGS+=	--with-apxs2=${APXS:Q}
.  endif
.endif	# APACHE_BUILDLINK3_MK

.include "../../devel/apr/buildlink3.mk"
.include "../../devel/apr-util/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}
