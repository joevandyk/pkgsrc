# $NetBSD: buildlink3.mk,v 1.1 2006/08/11 15:47:30 wiz Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
PCRE_OCAML_BUILDLINK3_MK:=	${PCRE_OCAML_BUILDLINK3_MK}+

.if ${BUILDLINK_DEPTH} == "+"
BUILDLINK_DEPENDS+=	pcre-ocaml
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Npcre-ocaml}
BUILDLINK_PACKAGES+=	pcre-ocaml
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}pcre-ocaml

.if ${PCRE_OCAML_BUILDLINK3_MK} == "+"
BUILDLINK_API_DEPENDS.pcre-ocaml+=	pcre-ocaml>=5.10.3nb1
BUILDLINK_PKGSRCDIR.pcre-ocaml?=	../../devel/pcre-ocaml
.endif	# PCRE_OCAML_BUILDLINK3_MK

.include "../../devel/pcre/buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}