# $NetBSD: Makefile,v 1.23 2007/10/17 13:50:30 jlam Exp $

DISTNAME=	courier-${COURIER_VERSION}
PKGNAME=	${DISTNAME:S/-/-mta-/}
PKGREVISION=	1
CATEGORIES=	mail
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=courier/}
EXTRACT_SUFX=	.tar.bz2

CONFLICTS+=	postfix-[0-9]* qmail-[0-9]* sendmail-[0-9]*

MAINTAINER=	jlam@pkgsrc.org
COMMENT=	Courier mail transport agent
HOMEPAGE=	http://www.courier-mta.org/

DEPENDS+=	courier-maildir>=${COURIER_VERSION}:../../mail/courier-maildir
DEPENDS+=	couriertcpd>=${COURIER_VERSION}:../../net/couriertcpd
DEPENDS+=	maildrop>=2.0.4nb2:../../mail/maildrop

USE_TOOLS+=		gmake openssl:run perl:run
USE_LANGUAGES=		c c++
GCC_REQD+=		3.0	# need Standard C++ Library

.include "Makefile.common"

PLIST_SRC+=		${PKGDIR}/PLIST

.include "pkginstall.mk"
.include "options.mk"

USERGROUP_PHASE=	configure

CONFIGURE_ENV+=		OPENSSL=${TOOLS_OPENSSL:Q}
CONFIGURE_ENV+=		PROCMAIL=${LOCALBASE:Q}/bin/procmail

CONFIGURE_ARGS+=	--datadir=${DATADIR:Q}
CONFIGURE_ARGS+=	--with-mailuid=${PKG_UID.${COURIER_USER}}
CONFIGURE_ARGS+=	--with-mailgid=${PKG_GID.${COURIER_GROUP}}
CONFIGURE_ARGS+=	--with-paranoid-smtpext
CONFIGURE_ARGS+=	--with-piddir=${COURIER_STATEDIR:Q}/tmp
CONFIGURE_ARGS+=	--with-transport=${COURIER_TRANSPORTS:M*:Q}
CONFIGURE_ARGS+=	--without-certdb

# This argument is actually here just to make the "webmail" configure
# script work.  The value is not actually used since in reality, we are
# using the sqwebmail package to provide the Courier webmail component.
#
CONFIGURE_ARGS+=	--enable-mimetypes=/nonexistent

INSTALL_DIRS=		webadmin courier
INSTALL_AM_MAKEFLAGS+=	sysconfdir=${EGDIR:Q}
INSTALL_AM_MAKEFLAGS+=	htmldocdir=${DOCDIR:Q}
INSTALL_MAKE_FLAGS=	${MAKE_FLAGS} AM_MAKEFLAGS=${INSTALL_AM_MAKEFLAGS:Q}

SUBST_CLASSES+=		courier
SUBST_FILES.courier=	courier/doc/mkesmtpdcert.8.in			\
			courier/doc/mkesmtpdcert.html.in		\
			courier/filters/courierfilter.8.in		\
			courier/filters/courierfilter.html.in		\
			courier/module.esmtp/esmtpd-msa.dist.in		\
			courier/module.esmtp/esmtpd-ssl.dist.in		\
			courier/module.esmtp/esmtpd.cnf.in		\
			courier/module.esmtp/esmtpd.dist.in		\
			courier/module.esmtp/mkesmtpdcert.in
SUBST_SED.courier=	-e "s|^ESMTPDSTART=.*|ESMTPDSTART=YES|g"	\
			-e "s|^ESMTPDSSLSTART=.*|ESMTPDSSLSTART=YES|g"	\
			-e "s|@datadir@/esmtpd.pem|@sysconfdir@/esmtpd.pem|g" \
			-e "s|@datadir@/esmtpd.rand|@sysconfdir@/esmtpd.rand|g" \
			-e "s|@libexecdir@/filters|@libexecdir@/courier/filters|g"
SUBST_STAGE.courier=	pre-configure

SUBST_CLASSES+=		perms
SUBST_FILES.perms=	courier/perms.sh.in
SUBST_SED.perms+=	-e "s,@REAL_ROOT_USER@,"${REAL_ROOT_USER:Q}",g"	\
			-e "s,@ROOT_USER@,"${ROOT_USER:Q}",g"		\
			-e "s,@ROOT_GROUP@,"${ROOT_GROUP:Q}",g"
SUBST_STAGE.perms=	pre-configure

SUBST_CLASSES+=		paths
SUBST_FILES.paths=	${WRKDIR}/mailer.conf
SUBST_SED.paths+=	-e 's,@PREFIX@,${PREFIX},g'
SUBST_STAGE.paths=	post-patch

REPLACE_PERL+=	courier/webadmin/*.pl courier/webadmin/*.pl.in webadmin/*.pl

.include "../../lang/perl5/buildlink3.mk"
.include "../../security/courier-authlib/buildlink3.mk"

post-extract:
	${CP} ${FILESDIR}/mailer.conf ${WRKDIR}/mailer.conf

post-build:
	${TOUCH} ${WRKDIR}/locallowercase

post-install:
	cd ${WRKSRC}/courier && \
		${SETENV} ${MAKE_ENV} ${MAKE_PROGRAM} install-permissions
	${CHOWN} ${COURIER_USER}:${COURIER_GROUP} \
		${DATADIR}/filterctl ${PREFIX}/sbin/courierfilter
	${CHMOD} 0500 ${DATADIR}/filterctl ${PREFIX}/sbin/courierfilter
	${INSTALL_DATA} ${WRKDIR}/mailer.conf ${EGDIR}
	${INSTALL_DATA} ${WRKDIR}/locallowercase ${EGDIR}/locallowercase

.include "../../mk/bsd.pkg.mk"
