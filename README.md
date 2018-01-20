# example macOS kernel extension built using make
Authored 2018, [Daniel Roethlisberger](//daniel.roe.ch/)  
https://github.com/droe/example.kext


## Overview

This skeleton example kernel extension for macOS demonstrates how to build
kexts without the opaque Xcode project bloat.  This is by no means rocket
science, but since there exists very little up-to-date documentation on how to
build kernel extensions manually, this might save someone some tinkering.


## Requirements

Tested primarily on El Capitan 10.11.6 (XNU 3248.72.11).  Patches to support
other macOS releases are very welcome.


## Installation

As of OS X 10.10 Yosemite, kernel extensions need to be signed.  You need to
enable `kext-dev-mode` in order to load unsigned kernel extensions:

1.  Run `sudo nvram boot-args=kext-dev-mode=1`
2.  Reboot

As of OS X 10.11 El Capitan, `kext-dev-mode` no longer has any effect.  You
need to disable the kext protection part of System Integrity Protection (SIP)
in order to load unsigned kernel extensions:

1.  Reboot into repair mode by pressing <kbd>cmd⌘</kbd>+<kbd>r</kbd>
2.  Run `csrutil enable --without kext`
3.  Reboot

To create a signed kext that will load in default system configuration with SIP
enabled, you will need to obtain a Developer ID certificate specifically for
signing kernel extensions.


## Support

There is no support whatsoever.  No communication except in the form of Github
pull requests or issues pertaining to bugs or missing features.


## Bugs

-   `Mk/kext.mk` does not support targeting a specific version of macOS.

