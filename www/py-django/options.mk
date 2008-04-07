# $NetBSD: options.mk,v 1.4 2007/02/22 19:27:24 wiz Exp $

PKG_OPTIONS_VAR =	PKG_OPTIONS.django
PKG_SUPPORTED_OPTIONS=	mysql psycopg1 psycopg2 sqlite
PKG_SUGGESTED_OPTIONS=	psycopg1

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mmysql)
DEPENDS+=	${PYPKGPREFIX}-mysqldb-[0-9]*:../../databases/py-mysqldb
PLIST_SUBST+=	COND_MYSQL=
.else
PLIST_SUBST+=	COND_MYSQL="@comment "
.endif

.if !empty(PKG_OPTIONS:Mpsycopg1)
DEPENDS+=	${PYPKGPREFIX}-psycopg-[0-9]*:../../databases/py-psycopg
.endif

.if !empty(PKG_OPTIONS:Mpsycopg2)
DEPENDS+=	${PYPKGPREFIX}-psycopg2-[0-9]*:../../databases/py-psycopg2
PLIST_SUBST+=	COND_PSYCOPG2=
.else
PLIST_SUBST+=	COND_PSYCOPG2="@comment "
.endif

.if !empty(PKG_OPTIONS:Mpsycopg1) || !empty(PKG_OPTIONS:Mpsycopg2)
PLIST_SUBST+=	COND_PSYCOPG1=
.else
PLIST_SUBST+=	COND_PSYCOPG1="@comment "
.endif

.if !empty(PKG_OPTIONS:Msqlite)
DEPENDS+=	${PYPKGPREFIX}-sqlite2-[0-9]*:../../databases/py-sqlite2
PLIST_SUBST+=	COND_SQLITE=
.else
PLIST_SUBST+=	COND_SQLITE="@comment "
.endif
