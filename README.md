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
Red Hat, Inc.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Red Hat Enterprise Linux 7.9

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
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/rhel-7.6/pjones.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Justin Forbes
- Position: Engineer
- Email address: jforbes@redhat.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/rhel-7.6/jforbes.pub

-----END PGP PUBLIC KEY BLOCK-----
-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
We have used upstream shim version 15
https://github.com/rhboot/shim/releases/tag/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://people.redhat.com/~pjones/shim-rhel-7/shim-15-7.el7_9.src.rpm

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Most of the master branch (basically all but the fraught openssl rebase and the
filesystem rearrangement) is backported here, plus a few patches that have been
proposed as PRs or are currently PR drafts, as well as two workarounds that
will be pushed as a PR on Wednesday.  The last two aren't pushed publicly
yet because they make it too clear what's going on right now IMO.  Each patch
in the src rpm except for the last two has one of the following in its
changelog:

Upstream-commit-id: $COMMITID
Upstream: pr#$PULL_REQUEST_NUMBER

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
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
Answer: Yes

* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
Answer: Affected grub2 signing cert removed from shim, new signing EV certificate introduced.
New grub2 builds with CVE fix will be signed with new signing EV certificate.


-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
None of the following commits are present:
475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
These kernels do not have that bug.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
Yes, for several linux kernel builds.  Yes.  The vendor db is included here as
db.x64.esl, and it includes the certificate redhatsecurebootca5.cer and the
authenticode hashes listed in db.x64.txt

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
Dockerfile to reproduce build is included.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
root.log and boot.log are in this repository.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
[your text here]
