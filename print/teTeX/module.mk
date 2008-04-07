# $NetBSD: module.mk,v 1.17 2006/08/10 03:35:33 minskim Exp $
#
# This Makefile fragment is intended to be included by packages that
# install TeX packages.  It takes care of rebuilding the ls-R database
# at (de)installation time.
#
# The following variables can be defined:
#
#    TEXMFDIRS - A list of TEXMF directories that need to update ls-R.
#                Default: ${PKG_LOCALTEXMFPREFIX}
#
#    TEX_FONTMAPS - A list of font map files
#

.if !defined(TEX_PACKAGE_MK)
TEX_PACKAGE_MK=		# defined

TEXMFDIRS?=		${PKG_LOCALTEXMFPREFIX}
TEX_FONTMAPS?=		# empty

.if !empty(TEX_FONTMAPS)
BUILDLINK_API_DEPENDS.teTeX-bin+=	teTeX-bin>=3.0nb4
.endif

FILES_SUBST+=		MKTEXLSR="${LOCALBASE}/bin/mktexlsr"
FILES_SUBST+=		TEXMFDIRS=${TEXMFDIRS:Q}
FILES_SUBST+=		UPDMAP_SYS="${LOCALBASE}/bin/updmap-sys"
FILES_SUBST+=		TEX_FONTMAPS=${TEX_FONTMAPS:Q}
INSTALL_TEMPLATES+=	../../print/teTeX/files/texmf.tmpl
DEINSTALL_TEMPLATES+=	../../print/teTeX/files/texmf.tmpl

PRINT_PLIST_AWK+=	/^(@dirrm )?${PKG_LOCALTEXMFPREFIX:S|${PREFIX}/||:S|/|\\/|g}(\/ls-R)?$$/ \
			{ next; }
PRINT_PLIST_AWK+=	/^(@dirrm )?${PKG_LOCALTEXMFPREFIX:S|${PREFIX}/||:S|/|\\/|g}/ \
			{ gsub(/${PKG_LOCALTEXMFPREFIX:S|${PREFIX}/||:S|/|\\/|g}/, "$${PKG_LOCALTEXMFPREFIX}"); }

.include "../../mk/tex.buildlink3.mk"

.endif			# TEX_PACKAGE_MK
