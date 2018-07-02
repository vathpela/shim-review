-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Red Hat, Inc.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Red Hat Enterprise Linux 7.6

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

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
None.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It can be built on the centos 7.5 docker image, plus the yum repo at
https://pjones.fedorapeople.org/rhel-7.6-shim-build-deps .  For your
convenience, a Dockerfile has been supplied at
https://github.com/vathpela/shim-review/blob/rhel-7.6/Dockerfile that can be
used to reproduce the entire build using the release tarball from github.  Use
it like this:

`sudo docker build -f Dockerfile -t rhel-7.6-shim-review .`

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/vathpela/shim-review/blob/rhel-7.6/root.log
https://github.com/vathpela/shim-review/blob/rhel-7.6/build.log

-------------------------------------------------------------------------------
Put info about what bootloader you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
It's grub2 with the well known set of secure boot patches (among other patches.)

-------------------------------------------------------------------------------
Put info about what kernel you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
It's the RHEL 7.6 kernel, which has the well known set of secure boot patches.

