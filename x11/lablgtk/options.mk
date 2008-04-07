# $NetBSD: options.mk,v 1.3 2007/10/27 13:29:38 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.lablgtk
PKG_SUPPORTED_OPTIONS=	glade gnomecanvas gtksourceview svg
PKG_SUGGESTED_OPTIONS=	gnomecanvas svg

.include "../../mk/bsd.options.mk"

.if !empty(PKG_OPTIONS:Mglade)
.include "../../devel/libglade/buildlink3.mk"
CONFIGURE_ARGS+=	--with-glade
PLIST_SRC+=		PLIST.glade
.else
CONFIGURE_ARGS+=	--without-glade
.endif

.if !empty(PKG_OPTIONS:Mgnomecanvas)
.include "../../devel/libgnomeui/buildlink3.mk"
.include "../../graphics/libgnomecanvas/buildlink3.mk"
.include "../../x11/gnome-panel/buildlink3.mk"
CONFIGURE_ARGS+=	--with-gnomecanvas
PLIST_SRC+=		PLIST.gnomecanvas
.else
CONFIGURE_ARGS+=	--without-gnomecanvas
.endif

.if !empty(PKG_OPTIONS:Mgtksourceview)
.include "../../x11/gtksourceview/buildlink3.mk"
CONFIGURE_ARGS+=	--with-gtksourceview
PLIST_SRC+=		PLIST.gtksourceview
.else
CONFIGURE_ARGS+=	--without-gtksourceview
.endif

.if !empty(PKG_OPTIONS:Msvg)
.include "../../graphics/librsvg/buildlink3.mk"
CONFIGURE_ARGS+=	--with-rsvg
PLIST_SRC+=		PLIST.svg
.else
CONFIGURE_ARGS+=	--without-rsvg
.endif

.if !empty(PKG_OPTIONS:Mgnomecanvas) || !empty(PKG_OPTIONS:Msvg)
PLIST_SRC+=		PLIST.gnome
.endif

PLIST_SRC+=	PLIST
