This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to keybase
- use channel names under your vendor/company to discuss the review process and to get an approval
- approval is ready when you have Approved-by: Peter Jones <pjones@redhat.com> or TODO: add list of confirmed approvers

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
VMware, https://www.vmware.com/
`
-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Photon OS, https://vmware.github.io/photon/

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Photon OS is a Linux distribution being used by VMware customers in a clouds (vSphere, AWS, etc) and on a bare metal. We use shim->grub2->Linux chain for Secure Boot support. It does need to be signed in order to boot the Phorot OS on any device using UEFI CA certificate for Secure Boot.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Monty Ijzerman
- Position: Staff Program Manager, Security Response
- Email address: mijzerman@vmware.com
- PGP: http://pgp.mit.edu/pks/lookup?op=vindex&search=0xC61F6A1D

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Edward Hawkins
- Position: Senior Security Program Manager
- Email address: ehawkins@vmware.com
- PGP: http://pgp.mit.edu/pks/lookup?op=vindex&search=0x405F7C6D

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/tag/15

Tarball sha256sum: 473720200e6dae7cfd3ce7fb27c66367a8d6b08233fe63f01aa1d6b3888deeb6 shim-15.tar.bz2

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/51413d1deb0df0debdf1d208723131ff0e36d3a3

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Compilation issue fix caused by typo.

sed -i 's/EFI_WARN_UNKOWN_GLYPH/EFI_WARN_UNKNOWN_GLYPH/' lib/console.c

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2: is CVE-2020-10713 fixed ?
-------------------------------------------------------------------------------
Yes

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2, and previous shims were trusting affected
by CVE-2020-10713 grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
-------------------------------------------------------------------------------
Yes
Yes

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
No. We use linux-4.19.y (no lockdown support)


-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
N/A

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
We use photon based docker image to build the shim. It has all necessary tools to build the shim. It also has build-shim.sh script which will pull sources, vendor cert and will build the shim binary. Shim binary will be at /shim-15/shimx64.efi

- $ docker run -it amakhalov/build-shim:20200721
- root [ / ]# ./build-shim.sh

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
build-shim.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
N/A
