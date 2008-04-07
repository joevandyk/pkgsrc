# $NetBSD: options.mk,v 1.2 2007/08/17 22:27:15 joerg Exp $

# Global and legacy options

PKG_OPTIONS_VAR=	PKG_OPTIONS.elk
PKG_SUPPORTED_OPTIONS= xaw motif
PKG_SUGGESTED_OPTIONS=

.include "../../mk/bsd.options.mk"

###
### x11 support
###
.if !empty(PKG_OPTIONS:Mxaw) || !empty(PKG_OPTIONS:Mmotif)
PLIST_SUBST+= WITHX11=""
.  if !empty(PKG_OPTIONS:Mxaw)
PLIST_SUBST+= WITHXAW=""
ELK_AWK="yes"
.    include "../../mk/xaw.buildlink3.mk"
.  else
PLIST_SUBST+= WITHXAW="@comment "
ELK_AWK="no"
.  endif
.  if !empty(PKG_OPTIONS:Mmotif)
.  include "../../mk/motif.buildlink3.mk"
PLIST_SUBST+= WITHMOTIF=""
.  else
PLIST_SUBST+= WITHMOTIF="@comment "
.  endif
.else
CONFIGURE_ARGS+=	--without-x
PLIST_SUBST+= WITHMOTIF="@comment "
PLIST_SUBST+= WITHX11="@comment "
PLIST_SUBST+= WITHXAW="@comment "
.endif
