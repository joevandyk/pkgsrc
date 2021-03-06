# $NetBSD: Makefile,v 1.15 2007/12/02 11:50:24 wiz Exp $

DISTNAME=	tk8.3.4
PKGNAME=	tk-8.3.4
PKGREVISION=	3
CATEGORIES=	x11
MASTER_SITES=	ftp://ftp.informatik.uni-hamburg.de/pub/soft/lang/tcl/tcl8_3/

MAINTAINER=	jwise@NetBSD.org
HOMEPAGE=	http://www.tcltk.com/
COMMENT=	Graphical toolkit for TCL

PKG_INSTALLATION_TYPES=	overwrite pkgviews

GNU_CONFIGURE=		yes
CONFIGURE_DIRS=		unix
CONFIGURE_ARGS+=	--with-tcl=${BUILDLINK_PREFIX.tcl}/lib

SUBST_CLASSES+=		tk834
SUBST_STAGE.tk834=	post-build
SUBST_FILES.tk834=	unix/tkConfig.sh
SUBST_SED.tk834+=	-e "s|${WRKSRC}/unix|${PREFIX}/lib|"
SUBST_SED.tk834+=	-e "s|${WRKSRC}|${PREFIX}/include/tk|"

MAKE_ENV+=		TOUCH=${TOUCH:Q}

USE_LIBTOOL=		yes
TEST_TARGET=		test

.include "../../mk/bsd.prefs.mk"

.if defined(ABI) && ${ABI} == "64"
CONFIGURE_ARGS+=	--enable-64bit
.endif

# Modify mkLinks script to remove the short-filename manpage if it was
# linked to a longer filename.
#
post-patch:
	@cd ${WRKSRC}/unix;						\
	${MV} -f mkLinks mkLinks.tmp;					\
	${GREP} -v "^exit 0" mkLinks.tmp > mkLinks;			\
	${CAT} mkLinks.tmp						\
		| ${AWK} '/^  *ln / { print $$2 }'			\
		| ${SORT} -u						\
		| ${GREP} -v ".*\.n"					\
		| ${SED} -e "s,^,${RM} -f ,"				\
		>> mkLinks;						\
	${RM} -f mkLinks.tmp;						\
	${CHMOD} +x mkLinks;

post-build:
	cd ${WRKSRC}/unix; for file in					\
		tkUnixInit.o libtk83.so wish;				\
	do								\
		${TOUCH} $${file};					\
	done

post-install:
	${RM} -f ${PREFIX}/bin/wish
	cd ${PREFIX}/bin && ${LN} -s wish8.3 wish
	${INSTALL_DATA_DIR} ${PREFIX}/include/tk
	${INSTALL_DATA_DIR} ${PREFIX}/include/tk/generic
	${INSTALL_DATA_DIR} ${PREFIX}/include/tk/unix
	${INSTALL_DATA} ${WRKSRC}/generic/default.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/ks_names.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tk.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tk3d.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkButton.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkCanvas.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkColor.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkDecls.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkFileFilter.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkFont.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkInitScript.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkInt.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkIntDecls.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkIntPlatDecls.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkIntXlibDecls.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkMenu.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkMenubutton.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkPlatDecls.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkPort.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkScale.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkScrollbar.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkSelect.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/generic/tkText.h ${PREFIX}/include/tk/generic
	${INSTALL_DATA} ${WRKSRC}/unix/tkUnixDefault.h ${PREFIX}/include/tk/unix
	${INSTALL_DATA} ${WRKSRC}/unix/tkUnixInt.h ${PREFIX}/include/tk/unix
	${INSTALL_DATA} ${WRKSRC}/unix/tkUnixPort.h ${PREFIX}/include/tk/unix

.include "../../lang/tcl83/buildlink3.mk"
.include "../../x11/libX11/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
