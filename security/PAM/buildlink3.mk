# $NetBSD: buildlink3.mk,v 1.24 2006/07/08 23:11:05 jlam Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
LINUX_PAM_BUILDLINK3_MK:=	${LINUX_PAM_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	linux-pam
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nlinux-pam}
BUILDLINK_PACKAGES+=	linux-pam
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}linux-pam

.if !empty(LINUX_PAM_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.linux-pam+=		PAM>=0.75
BUILDLINK_ABI_DEPENDS.linux-pam+=	PAM>=0.77nb5
BUILDLINK_PKGSRCDIR.linux-pam?=		../../security/PAM
.endif	# LINUX_PAM_BUILDLINK3_MK

.include "../../mk/dlopen.buildlink3.mk"

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
