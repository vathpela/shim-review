This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
### What organization or people are asking to have this signed?
-------------------------------------------------------------------------------
Red Hat, Inc.

-------------------------------------------------------------------------------
### What product or service is this for?
-------------------------------------------------------------------------------
Red Hat Enterprise Linux 8

-------------------------------------------------------------------------------
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
-------------------------------------------------------------------------------
We're a major bigtime OS vendor

-------------------------------------------------------------------------------
### Who is the primary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name: Peter Jones
- Position: Engineer
- Email address: pjones@redhat.com
- PGP key fingerprint: B00B 48BC 731A A884 0FED  9FB0 EED2 66B7 0F4F EF10
- PGP key: https://github.com/vathpela/shim-review/blob/rhel-7.6/pjones.pub

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Who is the secondary contact for security updates, etc.?
-------------------------------------------------------------------------------
- Name: Robbie Harwood
- Position: Engineer
- Email address: rharwood@redhat.com
- PGP key fingerprint: 039A 9CEA 19DE 9508 C368  75AA 2532 F917 6A95 A442
- PGP key: https://rharwood.fedorapeople.org/pubkey.gpg

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

-------------------------------------------------------------------------------
### Were these binaries created from the 15.5 shim release tar?
Please create your shim binaries starting with the 15.5 shim release tar file: https://github.com/rhboot/shim/releases/download/15.5/shim-15.5.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.5 and contains the appropriate gnu-efi source.

-------------------------------------------------------------------------------
This is the unmodified shim-15.6 release.

-------------------------------------------------------------------------------
### URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15.6 (eventually)
keybase://team/grub2.cve_2021_3695/shim/15.6 (I think)

-------------------------------------------------------------------------------
### What patches are being applied and why:
-------------------------------------------------------------------------------
None.

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
-------------------------------------------------------------------------------
This is a "RHEL-like" implementation.

-------------------------------------------------------------------------------
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list or the March 2021 grub2 CVE list:
* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
-------------------------------------------------------------------------------
shim builds from before SBAT support have been revoked, and the cert this shim
trusts has never been used to build any grub2 or kernel with these
vulnerabilities.

-------------------------------------------------------------------------------
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
-------------------------------------------------------------------------------
All of the following commits are present:

475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
435d1a471598752446a72ad1201b3c980526d869

And the configuration setting CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is disabled.

-------------------------------------------------------------------------------
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
-------------------------------------------------------------------------------
We don't use vendor_db in this build.

-------------------------------------------------------------------------------
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
-------------------------------------------------------------------------------
We don't use vendor_dbx in this build

-------------------------------------------------------------------------------
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
-------------------------------------------------------------------------------
This is built on a pre-release of RHEL 8.7.0.  The Dockerfile in this
repository can be used to launch an identical buildroot.  (Tested using podman,
so that's probably a better starting point.)

-------------------------------------------------------------------------------
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.

-------------------------------------------------------------------------------
root.log and build.log in this repo.

-------------------------------------------------------------------------------
### What changes were made since your SHIM was last signed?
-------------------------------------------------------------------------------
We switched to shim-15.6 and updated SBAT.

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
random:~/devel/github.com/shim-review/rhel-8.7-shim-20220601$ for x in shim*.efi ; do sha256sum ${x} ; done
cf6566a19a1c26d055983491f1b590453b2fe392ffd29530945eb811eeda63c9  shimia32.efi
c0c0aa417bfa857388a665d6feb956fe07aa880fbc5669c918aeec1ab7467a3b  shimx64.efi

random:~/devel/github.com/shim-review/rhel-8.6-shim-20220309$ for x in shim*.efi ; do pesign -P -h -i ${x} ; done
shimia32.efi b17d4dacd3e287bdb94967ce3812fdc943300e65711d7ef7aaad2ef2b9c70497
shimx64.efi 197cffb1108b98e440e825dfc07ad127a15b853770ac07815929a2387cfb3f32

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
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
-------------------------------------------------------------------------------
In grub builds that have "grub,2" we also use "grub.rh,2".

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
grub2-2.02-134.el8

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
It's based on 4.18.0, plus a full compliment of patches for Secure Boot and
relevant bug fixes.

-------------------------------------------------------------------------------
### Add any additional information you think we may need to validate this shim.
-------------------------------------------------------------------------------
THE MAGIC WORDS ARE SQUEAMISH OSSIFRAGE
