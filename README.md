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
SUSE, https://www.suse.com/

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
SUSE Linux Enterprice Server 15 SP2

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
SUSE is one of the major vendors in the Linux ecospace and this shim is a part
of a commercial support offering advertised publicly

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Johannes Segitz
- Position: Security Engineer
- Email address: jsegitz@suse.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
  EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Marcus Meissner
- Position: Project Manager Security
- Email address: meissner@suse.de
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:
  D33B C5C3 C0CC 59B6 3989  D77B EA7B F397 0175 623E

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
It is shim-15, up to https://github.com/rhboot/shim/commit/b3e4d1f7555aabbf5d54de5ea7cd7e839e7bd83d

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
FIXME

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
- gcc9-fix-warnings.patch: fixes build issues with gcc 9
- shim-always-mirror-mok-variables.patch: Mirror MOK variables correctly
- shim-arch-independent-names.patch: Make the names of EFI binaries arch-independent
- shim-bsc1092000-fallback-menu.patch: Make countdown function public
- shim-bsc1173411-only-check-efi-var-on-sb.patch: Only check EFI variable copying when Secure Boot is enabled
- shim-change-debug-file-path.patch: SUSE specific debug path
- shim-correct-license-in-headers.patch: Just license adjustments
- shim-fix-gnu-efi-3.0.11.patch: fixes a build error caused by the version of gnu-efi we use

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2: is CVE-2020-10713 fixed ?
-------------------------------------------------------------------------------
yes

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2, and previous shims were trusting affected
by CVE-2020-10713 grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
-------------------------------------------------------------------------------
- Yes FIXME
- Yes, we've rotated our signkey, so no old components can be started with this shim

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
We have that in current kernels and all older products will get these patches in the next update

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
[your text here] FIXME

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
[your text here]

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
build.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
