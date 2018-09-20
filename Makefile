KEXTNAME=	example
KEXTVERSION=	1.0.0
KEXTBUILD=	1.0.0d1
BUNDLEDOMAIN=	com.example
COPYRIGHT=	Copyright (c) 2018 John Doe. All rights reserved.

# Target an earlier version of macOS using an alternative Xcode installation
#DEVELOPER_DIR=	/Applications/Xcode-7.3.1.app/Contents/Developer
#MACOSX_VERSION_MIN=	10.11

# Use unsupported interfaces not part of the supported KPI
#CFLAGS=	-Wno-\#warnings
#KLFLAGS=	-unsupported

# Create a signed kext, see SIGNING IDENTITIES in codesign(1)
#DEVIDKEXT=	"your signing identity"

include Mk/kext.mk
