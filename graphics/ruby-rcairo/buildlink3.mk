# $NetBSD: buildlink3.mk,v 1.1.1.1 2006/07/23 16:57:25 minskim Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+

RUBY_RCAIRO_BUILDLINK3_MK:=	${RUBY_RCAIRO_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	${RUBY_PKGPREFIX}-rcairo
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:N${RUBY_PKGPREFIX}-rcairo}
BUILDLINK_PACKAGES+=	${RUBY_PKGPREFIX}-rcairo
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}${RUBY_PKGPREFIX}-rcairo

.if ${RUBY_RCAIRO_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.ruby18-rcairo+=	${RUBY_PKGPREFIX}-rcairo>=1.2.0
BUILDLINK_PKGSRCDIR.ruby18-rcairo?=	../../graphics/ruby-rcairo
.endif	# RUBY_RCAIRO_BUILDLINK3_MK

.include "../../graphics/cairo/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}