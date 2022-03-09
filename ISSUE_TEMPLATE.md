Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [ ] completed README.md file with the necessary information
 - [ ] shim.efi to be signed
 - [ ] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [ ] build logs
 - [ ] a Dockerfile to reproduce the build of the provided shim EFI binaries

This is for the shim-review branch at https://github.com/vathpela/shim-review/tree/rhel-9.0-shim-20220310/

-------------------------------------------------------------------------------
### What organization or people are asking to have this signed?
-------------------------------------------------------------------------------
Red Hat, Inc.

-------------------------------------------------------------------------------
### What product or service is this for?
-------------------------------------------------------------------------------
Red Hat Enterprise Linux 9

-------------------------------------------------------------------------------
### Please create your shim binaries starting with the 15.4 shim release tar file:  https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains the appropriate gnu-efi source.
### Please confirm this as the origin your shim.
-------------------------------------------------------------------------------
It's 15.5 not 15.4, but otherwise yes.

-------------------------------------------------------------------------------
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
-------------------------------------------------------------------------------
We're a major bigtime OS vendor

-------------------------------------------------------------------------------
### How do you manage and protect the keys used in your SHIM?
-------------------------------------------------------------------------------
The keys are in an HSM managed by our PSIRT team, builders talk to it over
https using gssapi for authentication, and each key is authorized for use by
specific tickets, the issuing of which is protected by ACLs for the user, the
package being built, and the build target.

-------------------------------------------------------------------------------
### Do you use EV certificates as embedded certificates in the SHIM?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### If you use new vendor_db functionality, are any hashes allow-listed?
### If yes: for what binaries?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
-------------------------------------------------------------------------------
All of the following commits are present:

475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
435d1a471598752446a72ad1201b3c980526d869

And the configuration setting CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is disabled.

-------------------------------------------------------------------------------
### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705, ( July 2020 grub2 CVE list + March 2021 grub2 CVE list ) and if you are shipping the shim_lock module CVE-2021-3418 fixed ?
-------------------------------------------------------------------------------
shim builds from before SBAT support have been revoked, and the cert this shim
trusts has never been used to build any grub2 or kernel with these
vulnerabilities.

-------------------------------------------------------------------------------
### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
-------------------------------------------------------------------------------
shim:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.redhat,1,Red Hat Inc,shim,15.5,secalert@redhat.com

grub:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.02,https://www.gnu.org/software/grub/
grub.rhel8,1,Red Hat Enterprise Linux 8,grub2,1:2.06-27.el9_0,mail:secalert@redhat.com

-------------------------------------------------------------------------------
### Were your old SHIM hashes provided to Microsoft ?
-------------------------------------------------------------------------------
Yes

-------------------------------------------------------------------------------
### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list ) grub2 bootloaders can not be verified ?
-------------------------------------------------------------------------------
Affected grub2 signing cert removed from shim, new certificate introduced.
New grub2 builds with CVE fix are signed with new signing certificate.

-------------------------------------------------------------------------------
### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
It is a "RHEL-like" implementation.

-------------------------------------------------------------------------------
### Which modules are built into your signed grub image?
-------------------------------------------------------------------------------
all_video boot blscfg btrfs cat configfile cryptodisk echo ext2 fat font
gcry_rijndael gcry_rsa gcry_serpent gcry_sha256 gcry_twofish gcry_whirlpool
gfxmenu gfxterm gzio halt hfsplus http increment iso9660 jpeg loadenv loopback
linux lvm luks mdraid09 mdraid1x minicmd net normal part_apple part_msdos
part_gpt password_pbkdf2 png reboot regexp search search_fs_uuid search_fs_file
search_label serial sleep syslinuxcfg test tftp video xfs efi_netfs efifwsetup
efinet lsefi lsefimmap connectefi backtrace chain usb usbserial_common
usbserial_pl2303 usbserial_ftdi usbserial_usbdebug keylayouts at_keyboard

-------------------------------------------------------------------------------
### What is the origin and full version number of your bootloader (GRUB or other)?
-------------------------------------------------------------------------------
grub2-2.06-27.el9_0

-------------------------------------------------------------------------------
### If your SHIM launches any other components, please provide further details on what is launched.
-------------------------------------------------------------------------------
It also launches fwupd.

-------------------------------------------------------------------------------
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
-------------------------------------------------------------------------------
grub2 verifies signatures on booted kernels via shim. fwupd does not include
code to launch other binaries, it can only load UEFI Capsule updates.

-------------------------------------------------------------------------------
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
-------------------------------------------------------------------------------
This is the same CA certificate we switched to for RHEL 8.3 /after/ the CVEs
landed.

-------------------------------------------------------------------------------
### How do the launched components prevent execution of unauthenticated code?
-------------------------------------------------------------------------------
grub2 verifies signatures on booted kernels via shim. fwupd does not include
code to launch other binaries, it can only load UEFI Capsule updates.

-------------------------------------------------------------------------------
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
-------------------------------------------------------------------------------
It's based on 5.14.0, plus a full compliment of patches for Secure Boot and
relevant bug fixes.

-------------------------------------------------------------------------------
### What changes were made since your SHIM was last signed?
-------------------------------------------------------------------------------
We dropped all the patches and switched to shim-15.5

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
random:~/devel/github.com/shim-review/rhel-8.6-shim-20220309$ sha256sum shimx64.efi
b927fb088644139db1bb8396ed38cf1e7597efaac50db5dbaebade81ab2c0072  shimx64.efi

random:~/devel/github.com/shim-review/rhel-8.6-shim-20220309$ pesign -P -h -i shimx64.efi
shimx64.efi 042a784d4ea190915d6769b41084c863ba35bbefd0a23655e64a50287c1ecb24
