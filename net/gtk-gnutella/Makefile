# $NetBSD: Makefile,v 1.59 2007/10/14 08:32:19 adam Exp $

DISTNAME=	gtk-gnutella-0.96.4
CATEGORIES=	net
MASTER_SITES=	${MASTER_SITE_SOURCEFORGE:=gtk-gnutella/}
EXTRACT_SUFX=	.tar.bz2

MAINTAINER=	adam@NetBSD.org
HOMEPAGE=	http://gtk-gnutella.sourceforge.net/
COMMENT=	GTK-based gnutella client

USE_PKGLOCALEDIR=	yes
USE_TOOLS+=		gmake msgfmt pkg-config
HAS_CONFIGURE=		yes
CONFIGURE_SCRIPT=	./Configure
CONFIGURE_ARGS+=	-d -e -r -s
CONFIGURE_ARGS+=	-D prefix=${PREFIX:Q}
CONFIGURE_ARGS+=	-D privlib="${PREFIX}/share/gtk-gnutella"
CONFIGURE_ARGS+=	-D sysman="${PREFIX}/man"
CONFIGURE_ARGS+=	-D locale="${PREFIX}/${PKGLOCALEDIR}/locale"
CONFIGURE_ARGS+=	-D cc=${CC:Q}
CONFIGURE_ARGS+=	-D ccflags="${CFLAGS:Unone}"
CONFIGURE_ARGS+=	-D yacc="yacc"
CONFIGURE_ARGS+=	-D official="true"
CONFIGURE_ARGS+=	-U optimize

.include "options.mk"

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../security/gnutls/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
