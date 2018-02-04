# macOS kernel extension makefile
# Authored 2018, Daniel Roethlisberger
# Provided under the Unlicense
# https://github.com/droe/example.kext

# Designed to be included from a Makefile which defines the following:
#
# NAME      short name of the kext (e.g. example)
# VREL      release version (e.g. 1.0.0)
# VDEV      development version (e.g. 1.0.0d1)
# QUAL      the reverse DNS notation prefix (e.g. com.example)
#
# Optionally, the Makefile can define the following:
#
# SIGNER    the label of the Developer ID cert in your keyring for code signing
# ARCH      x86_64 (default) or i386
# PREFIX    install/uninstall location (default /Library/Extensions/)
#
# CPPFLAGS  additional precompiler flags
# CFLAGS    additional compiler flags
# LDFLAGS   additional linker flags
# LIBS      additional libraries to link against
# KLFLAGS   additional kextlibs flags


# check mandatory vars

ifndef NAME
$(error NAME not defined)
endif

ifndef VREL
ifdef VDEV
VREL:=		$(VDEV)
else
$(error VREL not defined)
endif
endif

ifndef VDEV
ifdef VREL
VDEV:=		$(VREL)
else
$(error VDEV not defined)
endif
endif

ifndef QUAL
$(error QUAL not defined)
endif


# defaults
FQID?=		$(QUAL).kext.$(NAME)
ARCH?=		x86_64
#ARCH?=		i386
PREFIX?=	/Library/Extensions/

# standard defines and includes for kernel extensions
CPPFLAGS+=	-DKERNEL \
		-DKERNEL_PRIVATE \
		-DDRIVER_PRIVATE \
		-DAPPLE \
		-DNeXT \
		-I/System/Library/Frameworks/Kernel.framework/Headers \
		-I/System/Library/Frameworks/Kernel.framework/PrivateHeaders

# convenience defines
CPPFLAGS+=	-DNAME_S=\"$(NAME)\" \
		-DVDEV_S=\"$(VDEV)\" \
		-DVREL_S=\"$(VREL)\" \
		-DFQID=$(FQID) \

# c compiler flags
CFLAGS+=	-arch $(ARCH) \
		-fno-builtin \
		-fno-common \
		-mkernel \
		-msoft-float

# warnings
CFLAGS+=	-Wall

# linker flags
#LDFLAGS+=	-mmacosx-version-min=10.11
LDFLAGS+=	-arch $(ARCH)
LDFLAGS+=	-nostdlib \
		-Xlinker -kext \
		-Xlinker -object_path_lto \
		-Xlinker -export_dynamic

# libraries
#LIBS+=		-lkmodc++
LIBS+=		-lkmod
LIBS+=		-lcc_kext

# kextlibs flags
KLFLAGS+=	-c

# source, header, object and make files
SRCS:=		$(wildcard *.c)
HDRS:=		$(wildcard *.h)
OBJS:=		$(SRCS:.c=.o)
MKFS:=		$(wildcard Makefile GNUmakefile Mk/*.mk)


# targets

all: $(NAME).kext

%.o: %.c $(HDRS)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(OBJS): $(MKFS)

$(NAME): $(OBJS)
	$(CC) $(LDFLAGS) -static -o $@ $(LIBS) $^
	otool -h $@

Info.plist~: Info.plist.in
	cat $^ \
	| sed -e 's/__NAME__/$(NAME)/g' \
	      -e 's/__VDEV__/$(VDEV)/g' \
	      -e 's/__VREL__/$(VREL)/g' \
	      -e 's/__FQID__/$(FQID)/g' \
	>$@

$(NAME).kext: $(NAME) Info.plist~
	mkdir -p $@/Contents/MacOS
	cp $(NAME) $@/Contents/MacOS
	cat Info.plist~ \
	| sed -e 's/__LIBS__//g' \
	>$@/Contents/Info.plist
	cat Info.plist~ \
	| awk '/__LIBS__/ {system("kextlibs -xml $(KLFLAGS) $@");next}1' \
	>$@/Contents/Info.plist~
	mv $@/Contents/Info.plist~ $@/Contents/Info.plist
	touch $@
ifdef SIGNER
	codesign -s $(SIGNER) -f $(NAME).kext
endif

load: $(NAME).kext
	sudo chown -R root:wheel $(NAME).kext
	sudo sync
	sudo kextutil $(NAME).kext
	sudo chown -R $(USER):$(shell id -gn) $(NAME).kext
	sudo dmesg|grep $(NAME)|tail -1

stat:
	kextstat|grep $(NAME)

unload:
	sudo kextunload $(NAME).kext

install: $(NAME).kext uninstall
	sudo cp -pr $< $(PREFIX)/$<
	sudo chown -R root:wheel $(PREFIX)/$<

uninstall:
	sudo rm -rf $(PREFIX)/$(NAME).kext

clean:
	rm -rf $(NAME).kext $(NAME) Info.plist~ $(OBJS)


.PHONY: all load stat unload intall uninstall clean

