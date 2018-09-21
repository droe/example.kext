# Makefile for building macOS kernel extensions
Authored 2018, [Daniel Roethlisberger](//daniel.roe.ch/)  
https://github.com/droe/example.kext


## Overview

`Mk/kext.mk` is a makefile for building macOS kernel extensions without the
opaque Xcode project bloat.  This example kernel extension for macOS
demonstrates how to use `Mk/kext.mk`.

`Mk/xcode.mk` is a makefile for Xcode selection, macOS min version targeting
and SDK selection.  While it is used by `Mk/kext.mk` internally, it can also be
used standalone in makefiles for userspace code on macOS.

All this is by no means rocket science, but since there exists very little
up-to-date documentation on how to build kernel extensions manually, this might
save other inclined kernel hackers with a dislike for GUI based build
configuration some relief.

`Mk/kext.mk` and `Mk/xcode.mk` were originally written for
[xnumon](https://github.com/droe/xnumon), but have been made available in this
separate project under a less restrictive license.


## Requirements

For building kernel extensions, Apple recommends that you use the
[latest Xcode version](https://developer.apple.com/download/)
containing the SDK for the oldest macOS release you target.
That translates to using
latest Xcode 7 for targeting 10.11+,
latest Xcode 8 for targeting 10.12+,
latest Xcode 9 for targeting 10.13+ and
latest Xcode 10 for targeting 10.14+.
This is different from the recommendation for userland code, where the
recommendation is to use the latest Xcode version available regardless of which
macOS release you target.
Wikipedia maintains mappings of Xcode and their SDK versions in their
[Xcode](https://en.wikipedia.org/wiki/Xcode) article.
Use `xcode-select -s` to enable a specific Command Line Developer Tools base
directory as system-wide default or set `SDK` to the respective SDK name or
path.


## Installation

As of OS X 10.10 Yosemite, kernel extensions need to be signed by default.  You
need to enable `kext-dev-mode` in order to load unsigned kernel extensions:

1.  Run `sudo nvram boot-args=kext-dev-mode=1`
2.  Reboot

As of OS X 10.11 El Capitan, `kext-dev-mode` no longer has any effect.  You
need to disable the kext protection part of System Integrity Protection (SIP)
in order to load unsigned kernel extensions:

1.  Boot into Recovery OS by pressing <kbd>cmd⌘</kbd>+<kbd>r</kbd> during boot
2.  Run `csrutil enable --without kext`
3.  Reboot

To create a signed kext that will load in default system configuration with SIP
enabled, you will need to obtain a Developer ID certificate specifically for
signing kernel extensions.

As of macOS 10.13 High Sierra, all kexts need to be explicitly approved by the
user before they can be loaded.  Workarounds include disabling user approval or
allowing your Team ID to bypass user approval using `spctl kext-consent` from
Recovery OS or NetBoot/NetInstall/NetRestore images, or using Mobile Device
Management (MDM).  For details, refer to
[TN2459](https://developer.apple.com/library/archive/technotes/tn2459/).


## Support

There is no support whatsoever.  No communication except in the form of Github
pull requests or issues pertaining to bugs or missing features.


## Bugs

-   `Mk/kext.mk` only compiles c sources at this point, not C++ or Objective-C.

