# $NetBSD: Makefile,v 1.6 2007/02/22 19:26:18 wiz Exp $
#

DISTNAME=		postgresql-jdbc-8.1-${PGBUILD}.src
PKGNAME=		jdbc-postgresql81-${PGBUILD}
DISTFILES+=		${DISTNAME}.tar.gz ${JARDIST}
CATEGORIES=		databases
MASTER_SITES=		http://jdbc.postgresql.org/download/

MAINTAINER=		abs@NetBSD.org
HOMEPAGE=		http://jdbc.postgresql.org/
COMMENT=		PostgreSQL 8.1 JDBC3 driver

PGBUILD=		408
JARDIST=		postgresql-8.1-${PGBUILD}.jdbc3.jar
JARFILE=		postgresql81.jar
EXTRACT_ONLY=		${DISTFILES:N*.jar}

USE_JAVA=		run
USE_JAVA2=		1.4
NO_BUILD=	YES

EXAMPLEDIR=		share/examples/java/${PKGBASE}
DOCDIR=			share/doc/java/${PKGBASE}
PLIST_SUBST+=		JARFILE=${JARFILE:Q}
PLIST_SUBST+=		EXAMPLEDIR=${EXAMPLEDIR:Q}
PLIST_SUBST+=		DOCDIR=${DOCDIR:Q}

do-install:
	${INSTALL_DATA_DIR} ${PREFIX}/lib/java
	${INSTALL_DATA} ${DISTDIR}/${JARDIST} ${PREFIX}/lib/java/${JARFILE}
	${INSTALL_DATA_DIR} ${PREFIX}/${EXAMPLEDIR}
	${INSTALL_DATA} ${WRKSRC}/example/*.java ${PREFIX}/${EXAMPLEDIR}
	${INSTALL_DATA_DIR} ${PREFIX}/${DOCDIR}
	${INSTALL_DATA} ${WRKSRC}/README ${PREFIX}/${DOCDIR}

.include "../../mk/java-vm.mk"
.include "../../mk/bsd.pkg.mk"
