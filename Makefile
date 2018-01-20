NAME=		example
VREL=		1.0.0
VDEV=		1.0.0d1
QUAL=		com.example

# for creating a signed kext
#SIGNER=	"your Apple Developer ID certificate label"

# for using unsupported interfaces not part of the supported KPI
#CFLAGS=	-Wno-\#warnings
#KLFLAGS=	-unsupported

include Mk/kext.mk
