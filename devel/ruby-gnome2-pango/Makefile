# $NetBSD: Makefile,v 1.7 2007/08/19 14:31:25 obache Exp $
#

PKGNAME=		${RUBY_PKGPREFIX}-gnome2-pango-${VERSION}
PKGREVISION=		1
COMMENT=		Ruby binding of pango-1.x
CATEGORIES=		devel fonts

CONFLICTS+=		ruby-gnome2-pango-[0-9]*

RUBY_EXTCONF_SUBDIRS=	pango

DEPENDS+=		${RUBY_PKGPREFIX}-gnome2-glib>=${VERSION}:../../devel/ruby-gnome2-glib

USE_TOOLS+=		pkg-config

INSTALL_TARGET=		install

.include "../../devel/pango/buildlink3.mk"
.include "../../graphics/ruby-rcairo/buildlink3.mk"
.include "../../meta-pkgs/ruby-gnome2/Makefile.common"
