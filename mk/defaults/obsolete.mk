# $NetBSD: obsolete.mk,v 1.28 2007/01/30 07:09:40 wiz Exp $
#
# This file holds make(1) logic to allow obsolete or deprecated variables
# still to be used.  These may eventually disappear over time as the contents
# are, by definition, obsolete and deprecated.

.if defined(PRIV_CONF_DIR)
PKG_SYSCONFDIR.priv?=	${PRIV_CONF_DIR}
.endif

###
### Set PKG_LEGACY_OPTIONS based on to-be-deprecated global variables.
###

.if defined(KERBEROS)
.  if ${KERBEROS} == "4" && !empty(PKG_SUPPORTED_OPTIONS:Mkerberos4)
PKG_LEGACY_OPTIONS+=	kerberos4
PKG_OPTIONS_DEPRECATED_WARNINGS+="Deprecated variable KERBEROS used, use PKG_DEFAULT_OPTIONS+=kerberos4 instead."
.  elif !empty(PKG_SUPPORTED_OPTIONS:Mkerberos)
PKG_LEGACY_OPTIONS+=	kerberos
PKG_OPTIONS_DEPRECATED_WARNINGS+="Deprecated variable KERBEROS used, use PKG_DEFAULT_OPTIONS+=kerberos instead."
.  endif
.endif

PKG_OPTIONS_LEGACY_VARS+=	USE_INET6:inet6
