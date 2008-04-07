# $NetBSD: options.mk,v 1.22 2007/10/28 07:28:46 taca Exp $

# Recommended package options for various setups:
#
#   Standalone Samba server		cups
#   Domain Member server		cups ldap winbind
#   Active Directory Member server	ads cups winbind
#   Domain Controller			ldap winbind
#
PKG_OPTIONS_VAR=	PKG_OPTIONS.samba
PKG_SUPPORTED_OPTIONS=	acl ads cups ldap pam winbind

.include "../../mk/bsd.options.mk"

SAMBA_STATIC_MODULES:=	# empty

###
### Allow Samba to join as a member server of an Active Directory domain.
###
.if !empty(PKG_OPTIONS:Mads)
.  include "../../mk/krb5.buildlink3.mk"
.  if empty(PKG_OPTIONS:Mldap)
PKG_OPTIONS+=		ldap
.  endif
CONFIGURE_ARGS+=	--with-ads
CONFIGURE_ARGS+=	--with-krb5=${KRB5BASE:Q}

# ignore gssapi.h on Solaris as it conflicts with <gssapi/gssapi.h>
.  if ${OPSYS} == "SunOS"
CONFIGURE_ENV+=		ac_cv_header_gssapi_h=no
.  endif
.else
CONFIGURE_ARGS+=	--without-ads
CONFIGURE_ARGS+=	--without-krb5
.endif

###
### Access Control List support.
###
.if !empty(PKG_OPTIONS:Macl)
CONFIGURE_ARGS+=	--with-acl-support
.endif

###
### Native CUPS support for providing printing services.
###
.if !empty(PKG_OPTIONS:Mcups)
.  include "../../print/cups/buildlink3.mk"
CONFIGURE_ARGS+=	--enable-cups
PLIST_SUBST+=		CUPS=
INSTALLATION_DIRS+=	libexec/cups/backend

.PHONY: samba-cups-install
post-install: samba-cups-install
samba-cups-install:
	cd ${DESTDIR}${PREFIX}/libexec/cups/backend && \
		${LN} -fs ../../../bin/smbspool smb
.else
CONFIGURE_ARGS+=	--disable-cups
PLIST_SUBST+=		CUPS="@comment "
.endif

###
### Support LDAP authentication and storage of Samba account information.
###
.if !empty(PKG_OPTIONS:Mldap)
.  include "../../databases/openldap-client/buildlink3.mk"
CONFIGURE_ARGS+=	--with-ldap
.else
CONFIGURE_ARGS+=	--without-ldap
.endif

###
### Support PAM authentication and build smbpass and winbind PAM modules.
###
.if !empty(PKG_OPTIONS:Mpam)
.  include "../../security/PAM/module.mk"
CONFIGURE_ARGS+=	--with-pam
CONFIGURE_ARGS+=	--with-pam_smbpass
CONFIGURE_ARGS+=	--with-pammodulesdir=${PAM_INSTMODULEDIR}
PLIST_SUBST+=		PAM_SMBPASS=lib/security/pam_smbpass.so
PLIST_SUBST+=		PAM=
INSTALLATION_DIRS+=	${EGDIR}/pam_smbpass

.PHONY: samba-pam-smbpass-install
post-install: samba-pam-smbpass-install
samba-pam-smbpass-install:
	${INSTALL_DATA} ${WRKSRC}/pam_smbpass/README			\
		${DESTDIR}${PREFIX}/${DOCDIR}/README.pam_smbpass
	cd ${WRKSRC}/pam_smbpass/samples; for f in [a-z]*; do		\
		${INSTALL_DATA} $${f} \
			${DESTDIR}${PREFIX}/${EGDIR}/pam_smbpass/$${f};	\
	done
.else
PLIST_SUBST+=		PAM_SMBPASS="@comment no PAM smbpass module"
PLIST_SUBST+=		PAM="@comment "
.endif

###
### Support querying a PDC for domain user and group information, e.g.,
### through NSS or PAM.
###
.if !empty(PKG_OPTIONS:Mwinbind)
CONFIGURE_ARGS+=	--with-winbind

SAMBA_STATIC_MODULES:=	${SAMBA_STATIC_MODULES},idmap_rid
.  if !empty(PKG_OPTIONS:Mads)
SAMBA_STATIC_MODULES:=	${SAMBA_STATIC_MODULES},idmap_ad
.  endif

WINBINDD_RCD_SCRIPT=	winbindd
PLIST_SUBST+=		WINBIND=

# Install the PAM winbind module if we're also building with PAM support.
.  if empty(PKG_OPTIONS:Mpam)
PLIST_SUBST+=	PAM_WINBIND="@comment no PAM winbind module"
.  else
PLIST_SUBST+=	PAM_WINBIND=lib/security/pam_winbind.so
.  endif

# Install the NSS winbind module if it exists.
PLIST_SUBST+=		NSS_WINBIND=${NSS_WINBIND:Q}
NSS_WINBIND=		${NSS_WINBIND_cmd:sh}
NSS_WINBIND_cmd=	\
	${TEST} -x ${WRKSRC}/config.status ||				\
		{ ${ECHO} "@comment no NSS winbind module" ; exit 0; };	\
	cd ${WRKDIR} && ${ECHO} @WINBIND_NSS@ |				\
	${WRKSRC}/config.status --file=-:- | 				\
	${AWK} '/^$$/ { print "@comment no NSS winbind module"; exit 0; } \
		{ sub(".*/", "lib/"); print; }' &&			\
	${RM} -f config.log

.PHONY: samba-nss-winbind-install
post-install: samba-nss-winbind-install
samba-nss-winbind-install:
	lib=${WRKSRC:Q}/nsswitch/${NSS_WINBIND:T:Q};			\
	${TEST} ! -f $$lib || ${INSTALL_LIB} $$lib ${DESTDIR}${PREFIX:Q}/lib

# Install the NSS WINS module if it exists.
PLIST_SUBST+=	NSS_WINS=${NSS_WINS:Q}
NSS_WINS=	${NSS_WINS_cmd:sh}
NSS_WINS_cmd=	\
	${TEST} -x ${WRKSRC}/config.status ||				\
		{ ${ECHO} "@comment no NSS WINS module" ; exit 0; };	\
	cd ${WRKDIR} && ${ECHO} @WINBIND_WINS_NSS@ |			\
	${WRKSRC}/config.status --file=-:- |				\
	${AWK} '/^$$/ { print "@comment no NSS WINS module"; exit 0; }	\
		{ sub(".*/", "lib/"); print; }' &&			\
	${RM} -f config.log

.PHONY: samba-nss-wins-install
post-install: samba-nss-wins-install
samba-nss-wins-install:
	lib=${WRKSRC:Q}/nsswitch/${NSS_WINS:T:Q};			\
	${TEST} ! -f $$lib || ${INSTALL_LIB} $$lib ${DESTDIR}${PREFIX:Q}/lib
.else
CONFIGURE_ARGS+=	--without-winbind
PLIST_SUBST+=		WINBIND="@comment "
PLIST_SUBST+=		PAM_WINBIND="@comment no PAM winbind module"
PLIST_SUBST+=		NSS_WINBIND="@comment no NSS winbind module"
PLIST_SUBST+=		NSS_WINS="@comment no NSS WINS module"
.endif

###
### Add the optional static modules to the configuration.
###
.if !empty(SAMBA_STATIC_MODULES)
CONFIGURE_ARGS+=	--with-static-modules=${SAMBA_STATIC_MODULES:S/^,//}
.endif
