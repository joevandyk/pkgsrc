# $NetBSD: Makefile,v 1.4 2007/10/23 20:16:52 smb Exp $
#

DISTNAME=	fetchinfo-plugin-0.4.20
PKGNAME=	claws-mail-fetchinfo-plugin-0.4.20
CATEGORIES=	mail
MASTER_SITES=	http://claws-mail.org/downloads/plugins/
PKGREVISION=	2

MAINTAINER=	smb@NetBSD.org
COMMENT=	Inserts headers containing some download information

DEPENDS+=	claws-mail>=3.0.0:../../mail/claws-mail

.include "../../mk/bsd.prefs.mk"

GNU_CONFIGURE=	yes
USE_LIBTOOL=	yes
USE_TOOLS+=	pkg-config
USE_LANGUAGES+=	c

.include "../../mail/claws-mail/Makefile.vers"
.include "../../mail/claws-mail/buildlink3.mk"
.include "../../x11/gtk2/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
