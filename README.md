Note: this build differs from those in issue https://github.com/rhboot/shim-review/issues/146 only in the following ways:
- fixed shim package revision in .sbat data (cosmetic only)
- several minor bugfixes as listed in the patch list in https://github.com/vathpela/shim-review/blob/fedora-shim-20210414/README.md

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
The Fedora project

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Fedora Linux

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
We're a major bigtime OS vendor

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Peter Jones
- Position: Engineer
- Email address: pjones@redhat.com
- PGP key: https://github.com/vathpela/shim-review/blob/rhel-7.6/pjones.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Justin Forbes
- Position: Engineer
- Email address: jforbes@redhat.com
- PGP key: https://github.com/vathpela/shim-review/blob/rhel-7.6/jforbes.pub

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
This starts with the shim 15.4 release tarball.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
- Source rpm is: https://kojipkgs.fedoraproject.org//packages/shim-unsigned-x64/15.4/5.fc33/src/shim-unsigned-x64-15.4-5.fc33.src.rpm
- Repos for build deps etc are:
  - https://mirrors.fedoraproject.org/metalink?repo=fedora-33&arch=x86_64
  - https://mirrors.fedoraproject.org/metalink?repo=updates-released-f33&arch=x86_64

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
We have the following commits applied as patches:
- https://github.com/rhboot/shim/commit/822d07ad4f07ef66fe447a130e1027c88d02a394
- https://github.com/rhboot/shim/commit/a0f701501f73a0aabd1ef8d568183d05611b0a52
- https://github.com/rhboot/shim/commit/5b3ca0d2f7b5f425ba1a14db8ce98b8d95a2f89f
- https://github.com/rhboot/shim/commit/4068fd42c891ea6ebdec056f461babc6e4048844
- https://github.com/rhboot/shim/pull/364/commits/8b59591775a0412863aab9596ab87bdd493a9c1e

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
The signed bootloaders are derived from the grub 2.04 with all of the relevant
patches or grub 2.06 rc1.

-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
It is a "Fedora like" implementation in the grub 2.04 builds; a couple of those
patches are still applicable on the 2.06 rc1 versions.

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
Answer: No bootloader signed using the current certs is vulnerable to the
CVE-2020-10713 batch, and the shim requires requires .sbat verification, which
all of the new bootloaders have.

* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
Answer: Yes

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
All of the following commits are present:

475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
435d1a471598752446a72ad1201b3c980526d869

And the configuration setting CONFIG_EFI_CUSTOM_SSDT_OVERLAYS is disabled.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
We don't use it in this build.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
This build requires .sbat support, and that's already in all of the fixed grub2
builds but none of the pre-CVE ones.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If possible, provide a Dockerfile that rebuilds the shim.
-------------------------------------------------------------------------------
Dockerfile to reproduce build is included.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
root.log and build.log are in this repository.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
THE MAGIC WORDS ARE SQUEAMISH OSSIFRAGE
