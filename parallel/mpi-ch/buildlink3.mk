# $NetBSD: buildlink3.mk,v 1.10 2007/01/14 09:03:09 joerg Exp $

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH}+
MPICH_BUILDLINK3_MK:=	${MPICH_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	mpich
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nmpich}
BUILDLINK_PACKAGES+=	mpich
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}mpich

.if !empty(MPICH_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.mpich+=	mpich>=1.2.6
BUILDLINK_ABI_DEPENDS.mpich?=	mpich>=1.2.6nb3
BUILDLINK_PKGSRCDIR.mpich?=	../../parallel/mpi-ch
BUILDLINK_DEPMETHOD.mpich?=	build
.endif	# MPICH_BUILDLINK3_MK

.include "../../x11/libX11/buildlink3.mk"

BUILDLINK_DEPTH:=	${BUILDLINK_DEPTH:S/+$//}