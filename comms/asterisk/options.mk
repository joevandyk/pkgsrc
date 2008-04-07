# $NetBSD: options.mk,v 1.2 2006/01/13 20:32:38 riz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.asterisk
PKG_SUPPORTED_OPTIONS=	zaptel gtk
.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mzaptel)
# zaptel only supported under NetBSD at the moment
.  include "../../comms/zaptel-netbsd/buildlink3.mk"
PLIST_SUBST+=		ZAPTEL=
.else
MAKE_FLAGS+=	WITHOUT_ZAPTEL=1
PLIST_SUBST+=		ZAPTEL="@comment "
.endif

.if !empty(PKG_OPTIONS:Mgtk)
.  include "../../x11/gtk/buildlink3.mk"
MAKE_FLAGS+=	ASTERISK_USE_GTK=1
PLIST_SUBST+=		GTK=
.else
PLIST_SUBST+=		GTK="@comment "
.endif
