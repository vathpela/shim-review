This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

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
Red Hat Enterprise Linux 7.7

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
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/rhel-7.7/pjones.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Justin Forbes
- Position: Engineer
- Email address: jforbes@redhat.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/rhel-7.7/jforbes.pub

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/vathpela/mallory/tree/rhel-7.7

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
5 patches that are already upstream in the shim-16 work on master.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It can be built on the centos 7 docker image, plus the yum repo at
https://pjones.fedorapeople.org/rhel-7.7-shim-build-deps .  For your
convenience, a Dockerfile has been supplied at:

  https://github.com/vathpela/shim-review/blob/rhel-7.7/Dockerfile

which can be used to reproduce the entire build using the release tarball from
github.  Use it like this:

`sudo docker build -f Dockerfile -t rhel-7.7-shim-review .`

or:

`podman build -f Dockerfile -t rhel-7.7-shim-review .`

It will show sha256sums at the end of the build, and you can start a container
with the resulting image to go check everything out like this:

`sudo docker run -ti rhel-7.7-shim-review`

or

`podman run -ti rhel-7.7-shim-review`

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
- https://github.com/vathpela/shim-review/blob/rhel-7.7/root.log
- https://github.com/vathpela/shim-review/blob/rhel-7.7/build.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
THE MAGIC WORDS ARE SQUEAMISH OSSIFRAGE
