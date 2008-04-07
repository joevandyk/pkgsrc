# $NetBSD: linux-suse.mk,v 1.2 2007/08/23 18:20:32 jlam Exp $
#
# SuSE Linux
#

# Most Linux software only need suse>=6.4.
.for _version_ in ${EMUL_REQD:Msuse>=*:S/suse>=//}
SUSE_VERSION_REQD?=	${_version_}
.endfor
SUSE_VERSION_REQD?=	6.4

# When building the SuSE packages, force the Linux type to be the specific
# version of SuSE that is being built.
#
.if defined(SUSE_PKG) && defined(SUSE_VERSION)
EMUL_TYPE.linux=	suse-${SUSE_VERSION}
.endif

# EMUL_TYPE.linux can be "suse" or "suse-[0-9]*".  If the former, then use
# the default SuSE version, otherwise use the specific version requested.
#
.if !empty(EMUL_TYPE.linux:Msuse-9.1)
.  include "${PKGSRCDIR}/emulators/suse91_linux/emulator.mk"

.elif !empty(EMUL_TYPE.linux:Msuse-9.x)
   # use the highest version of SuSE-9.x
.  include "${PKGSRCDIR}/emulators/suse91_linux/emulator.mk"

.elif !empty(EMUL_TYPE.linux:Msuse-10.0)
.  include "${PKGSRCDIR}/emulators/suse100_linux/emulator.mk"

.elif !empty(EMUL_TYPE.linux:Msuse-10.x)
   # use the highest version of SuSE-10.x
.  include "${PKGSRCDIR}/emulators/suse100_linux/emulator.mk"

.elif !empty(EMUL_TYPE.linux:Msuse)
   # default to highest version of SuSE
.  include "${PKGSRCDIR}/emulators/suse100_linux/emulator.mk"

.else
EMUL_DISTRO=		suse-0
PKG_FAIL_REASON+=	"[linux-suse.mk] ${EMUL_TYPE.linux} is not a supported EMUL_TYPE.linux"
.endif

# XXX There should be a check here to verify that ${EMUL_DISTRO} satisfies
# XXX suse>=${SUSE_VERSION_REQD}.
