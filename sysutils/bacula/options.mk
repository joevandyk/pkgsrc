# $NetBSD: options.mk,v 1.10 2007/02/15 09:08:05 ghen Exp $

PKG_OPTIONS_VAR=		PKG_OPTIONS.bacula
PKG_SUPPORTED_OPTIONS=		python
PKG_OPTIONS_REQUIRED_GROUPS=	database
PKG_OPTIONS_GROUP.database=	catalog-sqlite catalog-sqlite3 catalog-pgsql catalog-mysql
PKG_SUGGESTED_OPTIONS=		catalog-sqlite

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mcatalog-sqlite)
.  include "../../databases/sqlite/buildlink3.mk"
CONFIGURE_ARGS+=	--with-sqlite=${BUILDLINK_PREFIX.sqlite}
BACULA_DB=		sqlite
.elif !empty(PKG_OPTIONS:Mcatalog-sqlite3)
.  include "../../databases/sqlite3/buildlink3.mk"
CONFIGURE_ARGS+=	--with-sqlite3=${BUILDLINK_PREFIX.sqlite3}
BACULA_DB=		sqlite3
.elif !empty(PKG_OPTIONS:Mcatalog-pgsql)
.  include "../../mk/pgsql.buildlink3.mk"
CONFIGURE_ARGS+=	--with-postgresql=${PGSQL_PREFIX:Q}
BACULA_DB=		postgresql
.elif !empty(PKG_OPTIONS:Mcatalog-mysql)
.  include "../../mk/mysql.buildlink3.mk"
CONFIGURE_ARGS+=	--with-mysql=${PREFIX:Q}
BACULA_DB=		mysql
.endif

.if !empty(PKG_OPTIONS:Mpython)
CONFIGURE_ARGS+=	--with-python=${LOCALBASE}/${PYINC}
.  include "../../lang/python/application.mk"
.  include "${PYPKGSRCDIR}/buildlink3.mk"
# we can't use REPLACE_INTERPRETER here because ./configure fills in the
# python path and the replace-interpreter stage happens before that.
SUBST_CLASSES+=		python
SUBST_MESSAGE.python=	Fixing Python interpreter path.
SUBST_STAGE.python=	post-configure
SUBST_FILES.python=	scripts/dvd-handler
SUBST_SED.python=	-e '1s,^\#!.*,\#! ${PYTHONBIN},'
.endif
