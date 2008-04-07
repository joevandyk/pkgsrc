# $NetBSD: options.mk,v 1.2 2007/01/22 12:23:39 obache Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.ipa_sdb
PKG_SUPPORTED_OPTIONS=	ipa-without-autorules ipa-without-limits \
			ipa-without-rules ipa-without-thresholds

.include "../../mk/bsd.options.mk"

###
### Disable dynamic rules support
###
.if !empty(PKG_OPTIONS:Mipa-without-autorules)
CONFIGURE_ARGS+= --disable-autorules
.endif

###
### Disable limits support
###
.if !empty(PKG_OPTIONS:Mipa-without-limits)
CONFIGURE_ARGS+= --disable-limits
.endif

###
### Disable static rules support
###
.if !empty(PKG_OPTIONS:Mipa-without-rules)
CONFIGURE_ARGS+= --disable-rules
.endif

###
### Disable thresholds support
###
.if !empty(PKG_OPTIONS:Mipa-without-thresholds)
CONFIGURE_ARGS+= --disable-thresholds
.endif
