# $NetBSD: tools.Darwin.mk,v 1.36 2007/11/26 16:19:08 tron Exp $
#
# System-supplied tools for the Darwin (Mac OS X) operating system.

TOOLS_PLATFORM.[?=		[			# shell builtin
TOOLS_PLATFORM.awk?=		/usr/bin/awk
TOOLS_PLATFORM.basename?=	/usr/bin/basename
TOOLS_PLATFORM.bash?=		/bin/bash
# Darwin's bison is too old (1.28).
# TOOLS_PLATFORM.bison?=		/usr/bin/bison
# TOOLS_PLATFORM.bison-yacc?=	/usr/bin/bison -y
TOOLS_PLATFORM.byacc?=		/usr/bin/yacc
.if exists(/usr/bin/bzcat)
TOOLS_PLATFORM.bzcat?=		/usr/bin/bzcat
.endif
.if exists(/usr/bin/bzip2)
TOOLS_PLATFORM.bzip2?=		/usr/bin/bzip2
.endif
TOOLS_PLATFORM.cat?=		/bin/cat
TOOLS_PLATFORM.chgrp?=		/usr/bin/chgrp
TOOLS_PLATFORM.chmod?=		/bin/chmod
TOOLS_PLATFORM.chown?=		/usr/sbin/chown
TOOLS_PLATFORM.cmp?=		/usr/bin/cmp
TOOLS_PLATFORM.cp?=		/bin/cp
TOOLS_PLATFORM.csh?=		/bin/tcsh
TOOLS_PLATFORM.cut?=		/usr/bin/cut
TOOLS_PLATFORM.date?=		/bin/date
TOOLS_PLATFORM.diff?=		/usr/bin/diff
TOOLS_PLATFORM.dirname?=	/usr/bin/dirname
TOOLS_PLATFORM.echo?=		echo			# shell builtin
TOOLS_PLATFORM.egrep?=		/usr/bin/egrep
TOOLS_PLATFORM.env?=		/usr/bin/env
TOOLS_PLATFORM.expr?=		/bin/expr
TOOLS_PLATFORM.false?=		false			# shell builtin
TOOLS_PLATFORM.fgrep?=		/usr/bin/fgrep
TOOLS_PLATFORM.file?=		/usr/bin/file
TOOLS_PLATFORM.find?=		/usr/bin/find
TOOLS_PLATFORM.flex?=		/usr/bin/flex
TOOLS_PLATFORM.gmake?=		/usr/bin/gnumake
TOOLS_PLATFORM.gm4?=		/usr/bin/gm4
TOOLS_PLATFORM.grep?=		/usr/bin/grep
TOOLS_PLATFORM.gtar?=		/usr/bin/gnutar
TOOLS_PLATFORM.gunzip?=		/usr/bin/gunzip -f
TOOLS_PLATFORM.gzcat?=		/usr/bin/gzcat
TOOLS_PLATFORM.gzip?=		/usr/bin/gzip -nf ${GZIP}
TOOLS_PLATFORM.head?=		/usr/bin/head
TOOLS_PLATFORM.hostname?=	/bin/hostname
TOOLS_PLATFORM.id?=		/usr/bin/id
TOOLS_PLATFORM.ident?=		/usr/bin/ident
TOOLS_PLATFORM.install?=	/usr/bin/install
.if exists(/usr/bin/install-info)
TOOLS_PLATFORM.install-info?=	/usr/bin/install-info
.endif
.if exists(/bin/ksh)
TOOLS_PLATFORM.ksh?=		/bin/ksh
.endif
TOOLS_PLATFORM.ldconfig?=	/sbin/ldconfig
TOOLS_PLATFORM.lex?=		/usr/bin/lex
TOOLS_PLATFORM.ln?=		/bin/ln
TOOLS_PLATFORM.ls?=		/bin/ls
TOOLS_PLATFORM.m4?=		/usr/bin/m4
TOOLS_PLATFORM.mail?=		/usr/bin/mail
.if exists(/usr/bin/makeinfo)
TOOLS_PLATFORM.makeinfo?=	/usr/bin/makeinfo
.endif
TOOLS_PLATFORM.mkdir?=		/bin/mkdir -p
TOOLS_PLATFORM.mktemp?=		/usr/bin/mktemp
TOOLS_PLATFORM.mtree?=		/usr/sbin/mtree
TOOLS_PLATFORM.mv?=		/bin/mv
TOOLS_PLATFORM.nice?=		/usr/bin/nice
TOOLS_PLATFORM.nroff?=		/usr/bin/nroff
TOOLS_PLATFORM.openssl?=	/usr/bin/openssl
TOOLS_PLATFORM.patch?=		/usr/bin/patch
TOOLS_PLATFORM.printf?=		/usr/bin/printf
TOOLS_PLATFORM.pwd?=		/bin/pwd
TOOLS_PLATFORM.rm?=		/bin/rm
TOOLS_PLATFORM.rmdir?=		/bin/rmdir
TOOLS_PLATFORM.sed?=		/usr/bin/sed
TOOLS_PLATFORM.sh?=		/bin/sh
.if exists(/usr/bin/shlock)
TOOLS_PLATFORM.shlock?=		/usr/bin/shlock
.endif
TOOLS_PLATFORM.sleep?=		/bin/sleep
TOOLS_PLATFORM.sort?=		/usr/bin/sort
TOOLS_PLATFORM.strip?=		/usr/bin/strip
TOOLS_PLATFORM.tail?=		/usr/bin/tail
TOOLS_PLATFORM.tar?=		/usr/bin/tar
.if exists(/usr/bin/tbl)
TOOLS_PLATFORM.tbl?=		/usr/bin/tbl
.endif
TOOLS_PLATFORM.tclsh?=		/usr/bin/tclsh
TOOLS_PLATFORM.tee?=		/usr/bin/tee
TOOLS_PLATFORM.test?=		test			# shell builtin
TOOLS_PLATFORM.touch?=		/usr/bin/touch
TOOLS_PLATFORM.tr?=		/usr/bin/tr
TOOLS_PLATFORM.true?=		true			# shell builtin
TOOLS_PLATFORM.tsort?=		/usr/bin/tsort
TOOLS_PLATFORM.unzip?=		/usr/bin/unzip
TOOLS_PLATFORM.wc?=		/usr/bin/wc
.if exists(/usr/bin/wish)
TOOLS_PLATFORM.wish?=		/usr/bin/wish
.endif
TOOLS_PLATFORM.xargs?=		/usr/bin/xargs
TOOLS_PLATFORM.yacc?=		/usr/bin/yacc
