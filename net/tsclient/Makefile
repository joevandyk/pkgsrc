# $NetBSD: Makefile,v 1.40 2007/09/21 13:04:13 wiz Exp $
#

DISTNAME=		tsclient-0.132
PKGREVISION=		20
CATEGORIES=		net
MASTER_SITES=		http://www.gnomepro.com/tsclient/

MAINTAINER=		pkgsrc-users@NetBSD.org
HOMEPAGE=		http://www.gnomepro.com/tsclient/
COMMENT=		GNOME2 Frontend for rdesktop

DEPENDS+=	rdesktop-[0-9]*:../../net/rdesktop
DEPENDS+=	vncviewer-[0-9]*:../../net/vncviewer

USE_DIRS+=		gnome2-1.5
USE_TOOLS+=		gmake intltool msgfmt perl:run pkg-config
USE_PKGLOCALEDIR=	yes
GNU_CONFIGURE=		yes

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../x11/gnome-panel/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
