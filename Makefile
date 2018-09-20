KEXTNAME=	example
KEXTVERSION=	1.0.0
KEXTBUILD=	1.0.0d1
BUNDLEDOMAIN=	com.example

# creating a signed kext
#DEVIDKEXT=	"your Apple Developer ID certificate label"

# targeting an explicit version of macOS
#MACOSX_VERSION_MIN=	10.11

# using unsupported interfaces not part of the supported KPI
#CFLAGS=	-Wno-\#warnings
#KLFLAGS=	-unsupported

include Mk/kext.mk
