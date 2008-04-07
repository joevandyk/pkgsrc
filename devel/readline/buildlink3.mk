# $NetBSD: buildlink3.mk,v 1.28 2007/01/17 03:11:18 rillig Exp $

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH}+
READLINE_BUILDLINK3_MK:=	${READLINE_BUILDLINK3_MK}+

.if !empty(BUILDLINK_DEPTH:M+)
BUILDLINK_DEPENDS+=	readline
.endif

BUILDLINK_PACKAGES:=	${BUILDLINK_PACKAGES:Nreadline}
BUILDLINK_PACKAGES+=	readline
BUILDLINK_ORDER:=	${BUILDLINK_ORDER} ${BUILDLINK_DEPTH}readline

.if !empty(READLINE_BUILDLINK3_MK:M+)
BUILDLINK_API_DEPENDS.readline+=		readline>=2.2
BUILDLINK_ABI_DEPENDS.readline+=	readline>=5.0
BUILDLINK_PKGSRCDIR.readline?=		../../devel/readline

BUILDLINK_FILES.readline+=	include/history.h
BUILDLINK_FILES.readline+=	include/readline.h

BUILDLINK_FNAME_TRANSFORM.readline+= \
	-e "s|include/history\.h|include/readline/history.h|g"		\
	-e "s|include/readline\.h|include/readline/readline.h|g"

# Many GNU configure scripts don't check for the correct termcap library
# when testing for -lreadline.  If BROKEN_READLINE_DETECTION is set to
# "yes", then automatically add the right one.
#
.  include "../../mk/bsd.fast.prefs.mk"
BROKEN_READLINE_DETECTION?=	no
.  if !empty(BROKEN_READLINE_DETECTION:M[yY][eE][sS])
BUILDLINK_RL_TERMLIB.Linux=	curses
BUILDLINK_RL_TERMLIB.*=		termcap
.    if defined(BUILDLINK_RL_TERMLIB.${OPSYS})
BUILDLINK_RL_TERMLIB?=		${BUILDLINK_RL_TERMLIB.${OPSYS}}
.    else
BUILDLINK_RL_TERMLIB?=		${BUILDLINK_RL_TERMLIB.*}
.    endif
BUILDLINK_TRANSFORM+=		l:readline:readline:${BUILDLINK_RL_TERMLIB}
.  endif
.endif	# READLINE_BUILDLINK3_MK

BUILDLINK_DEPTH:=		${BUILDLINK_DEPTH:S/+$//}
