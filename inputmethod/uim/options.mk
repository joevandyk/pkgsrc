# $NetBSD: options.mk,v 1.10 2007/01/20 16:56:43 wiz Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.uim
PKG_SUPPORTED_OPTIONS=	anthy canna eb gtk qt
PKG_SUGGESTED_OPTIONS=	anthy canna gtk

.include "../../mk/bsd.options.mk"

PLIST_SUBST+=		HELPERDATA="@comment "
PLIST_SUBST+=		UIM_DICT_GTK="@comment "

.if !empty(PKG_OPTIONS:Manthy)
.  include "../../inputmethod/anthy/buildlink3.mk"
CONFIGURE_ARGS+=	--with-anthy --enable-dict
PLIST_SUBST+=		ANTHY=
.  if !empty(PKG_OPTIONS:Mgtk)
PLIST_SUBST+=		HELPERDATA=
PLIST_SUBST+=		UIM_DICT_GTK=
.  endif
.else
CONFIGURE_ARGS+=	--without-anthy
PLIST_SUBST+=		ANTHY="@comment "
.endif

.if !empty(PKG_OPTIONS:Mcanna)
.  include "../../inputmethod/canna-lib/buildlink3.mk"
CONFIGURE_ARGS+=	--with-canna
PLIST_SUBST+=		CANNA=
.else
CONFIGURE_ARGS+=	--without-canna
PLIST_SUBST+=		CANNA="@comment "
.endif

.if !empty(PKG_OPTIONS:Meb)
.include "../../textproc/eb/buildlink3.mk"
.else
CONFIGURE_ARGS+=	--without-eb
.endif

.if !empty(PKG_OPTIONS:Mgtk)
.include "../../x11/gtk2/modules.mk"
PLIST_SUBST+=		GTK=
.else
CONFIGURE_ARGS+=	--without-gtk2
PLIST_SUBST+=		GTK="@comment "
.endif

.if !empty(PKG_OPTIONS:Mqt)
.  include "../../x11/kdelibs3/buildlink3.mk"
.  include "../../x11/qt3-libs/buildlink3.mk"
BUILD_DEPENDS+=		qt3-tools-3.*:../../x11/qt3-tools
CONFIGURE_ARGS+=	--with-qt CXXFLAGS=-lc
# Not worked this option.  need immodule patch for Qt3
#CONFIGURE_ARGS+=	--with-qt-immodule
PLIST_SUBST+=		HELPERDATA=
PLIST_SUBST+=		QT=
.else
PLIST_SUBST+=		QT="@comment "
.endif
