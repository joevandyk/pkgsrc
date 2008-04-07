# $NetBSD: openwin.mk,v 1.4 2006/05/22 22:22:04 jlam Exp $

FILES_LIST=	${FILESDIR}/openwin

# Fix bugs in older versions of openwin headers
STDC_REPLACE=	-e 's/^\#if (__STDC__/\#if (defined(__STDC__)/'
STDC_REPLACE+=	-e 's/^\#if ((__STDC__/\#if ((defined(__STDC__)/'

CREATE_X11LINK=	case $$file in						\
		include/X11/Xlibint.h)					\
			${SED} ${STDC_REPLACE} < $$src > $$dest;	\
			;;						\
		include/X11/Xmd.h)					\
			${SED} ${STDC_REPLACE} < $$src > $$dest;	\
			;;						\
		include/X11/extensions/multibufst.h)			\
			${SED} ${STDC_REPLACE} < $$src > $$dest;	\
			;;						\
		*)							\
			${LN} -s $$src $$dest;				\
		esac

# disable checking of shared library dependencies, as openwin/dt can
# have some libraries missing in a "normal" installation and this
# shouldn't break the package.
#
CHECK_SHLIBS_SUPPORTED=	no
