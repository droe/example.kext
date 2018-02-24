KEXTNAME=	example
KEXTVERSION=	1.0.0
KEXTBUILD=	1.0.0d1
BUNDLEDOMAIN=	com.example

# for creating a signed kext
#SIGNCERT=	"your Apple Developer ID certificate label"

# for using unsupported interfaces not part of the supported KPI
#CFLAGS=	-Wno-\#warnings
#KLFLAGS=	-unsupported

include Mk/kext.mk
