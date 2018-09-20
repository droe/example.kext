KEXTNAME=	example
KEXTVERSION=	1.0.0
KEXTBUILD=	1.0.0d1
BUNDLEDOMAIN=	com.example

# creating a signed kext
#DEVIDKEXT=	"your signing identity, see SIGNING IDENTITIES in codesign(1)"

# targeting an earlier version of macOS using an alternative Xcode installation
#DEVELOPER_DIR=	/Applications/Xcode-7.3.1.app/Contents/Developer
#MACOSX_VERSION_MIN=	10.11

# using unsupported interfaces not part of the supported KPI
#CFLAGS=	-Wno-\#warnings
#KLFLAGS=	-unsupported

include Mk/kext.mk
