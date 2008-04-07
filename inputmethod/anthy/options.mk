# $NetBSD: options.mk,v 1.2 2007/08/30 20:19:45 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.anthy
PKG_SUPPORTED_OPTIONS=	anthy-2ch-dict anthy-okinawa-dict
PKG_OPTIONS_LEGACY_OPTS+=	2ch_dict:anthy-2ch-dict
PKG_OPTIONS_LEGACY_OPTS+=	okinawa_dict:anthy-okinawa-dict

.include	"../../mk/bsd.options.mk"

###
### Optional dictionary support
###
.if !empty(PKG_OPTIONS:Manthy-2ch-dict)
DISTFILES+=	2ch.t
SITES.2ch.t+=	http://omaemona.sourceforge.net/packages/Zisyo/
.endif

.if !empty(PKG_OPTIONS:Manthy-okinawa-dict)
OKIDIC_VERSION=			okinawa-20070717
DISTFILES+=			${OKIDIC_VERSION}.t
SITES.${OKIDIC_VERSION}.t+=	http://www.ofug.net/~yamajun/files/
.endif
