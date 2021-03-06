# $NetBSD: Makefile,v 1.2 2007/12/25 06:03:54 taca Exp $
# FreeBSD Id: ports/www/zope29/Makefile,v 1.86 2006/08/03 15:53:04 garga Exp

DISTNAME=	Zope-${ZOPE210_VERSION}-final
PKGNAME=	${ZOPE_PKG_PREFIX}-${ZOPE210_VERSION}
CATEGORIES=	www python
MASTER_SITES=	http://www.zope.org/Products/Zope/${ZOPE210_VERSION}/
EXTRACT_SUFX=	.tgz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://www.zope.org/
COMMENT=	Zope, the Z Object Publishing Environment

DEPENDS+=	${PYPKGPREFIX}-expat>=0:../../textproc/py-expat

PYTHON_VERSIONS_ACCEPTED=	24
ZOPE_VERSION=			210

HAS_CONFIGURE=		yes
CONFIGURE_ARGS+=	--prefix=${ZOPE_DIR} --with-python=${PYTHONBIN} --quiet
BUILD_TARGET=		build version_txt
MAKE_FILE=		makefile
#PKG_DESTDIR_SUPPORT=	user-destdir
#INSTALLATION_DIRS+=	${ZOPE_DOC_BASE}/zeo ${ZOPE_DOC_BASE}/zope
##			${ZOPE_BASE}/bin

PKG_GROUPS_VARS+=	ZOPE_GROUP
PKG_USERS_VARS+=	ZOPE_USER

OWN_DIRS+= ${ZOPE_BASE}/skel/etc/package-includes ${ZOPE_PRODUCTS_BASE}

PKG_GROUPS=	${ZOPE_GROUP}
PKG_USERS=	${ZOPE_USER}:${ZOPE_GROUP}
RCD_SCRIPTS=	zope${ZOPE_VERSION} zeo${ZOPE_VERSION}

FILES_SUBST+=	RCVAR_SUFFIX=${RCVAR_SUFFIX} VER=${ZOPE210_VERSION}
MESSAGE_SUBST+=	RCVAR_SUFFIX=${RCVAR_SUFFIX} ZOPE_VERSION=${ZOPE_VERSION}

SUBST_CLASSES+=		param
SUBST_STAGE.param=	pre-configure
SUBST_FILES.param+=	skel/etc/zope.conf.in utilities/mkzopeinstance.py
SUBST_SED.param+=  -e "s|@ZOPE_PRODUCTS_DIR@|${ZOPE_PRODUCTS_DIR}|g"
SUBST_SED.param+=	-e "s|@ZOPE_USER@|${ZOPE_USER}|g"
SUBST_SED.param+=	-e "s|@ZOPE_GROUP@|${ZOPE_GROUP}|g"
SUBST_MESSAGE.param=	Fixing some parameters in files.

REPLACE_PYTHON=		test.py lib/python/Zope2/Startup/zopectl.py \
			lib/python/zdaemon/zdctl.py lib/python/zdaemon/zdrun.py
REPLACE_PYTHON_DIRS+=	${WRKSRC}/lib/python/ZEO/scripts ${WRKSRC}/utilities

.include "../../mk/bsd.prefs.mk"

.if ${_USE_DESTDIR} == "no"
PRIVILEGED_STAGES+=	clean
.endif

.if ${OPSYS} == "FreeBSD"
RCVAR_SUFFIX=	_enable
.else
RCVAR_SUFFIX=	# empty
.endif

OWN_DIRS+=	${ZOPE_PRODUCTS_DIR}

post-patch:
	${FIND} ${WRKSRC}/doc ${WRKSRC}/lib ${WRKSRC}/skel/import \
		-type f -print0 | ${XARGS} -0 -- ${CHMOD} -x

post-build:
	cd ${WRKSRC}; ${PY_COMPILE_ALL} .

pre-install:
	${FIND} ${WRKSRC} \( -name '*.orig' -o -name svn-commit.tmp \) \
		-print0 | ${XARGS} -0 -- ${RM}

post-install:
	${INSTALL_DATA_DIR} ${ZOPE_DOC_DIR}/zeo
	${INSTALL_DATA_DIR} ${ZOPE_DOC_DIR}/zope
	cd ${WRKSRC}/doc/ZEO; ${PAX} -rw *.txt ${ZOPE_DOC_DIR}/zeo
	cd ${WRKSRC}/doc; ${PAX} -rw *.txt ${ZOPE_DOC_DIR}/zope
	${FIND} ${ZOPE_DIR} ${ZOPE_DOC_DIR} -type f -print0 \
		| ${XARGS} -0 -- ${CHMOD} a-w+r
	${FIND} ${ZOPE_DIR} -type f -name '*.pyc' -print0 | \
		${XARGS} -0 -- ${CHMOD} a-x

.include "../../www/zope/replace.mk"
.include "../../www/zope/zopeversion.mk"
.include "../../lang/python/application.mk"
.include "../../mk/bsd.pkg.mk"
