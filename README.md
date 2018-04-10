-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
The Fedora linux distribution ( https://www.fedoraproject.org/ )

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Fedora 28

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
We're a real big linux distro.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Peter Jones
- Position: Engineer
- Email address: pjones@redhat.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/fedora-28/pjones.pub


-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Justin Forbes
- Position: Engineer
- Email address: jforbes@redhat.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community: https://github.com/vathpela/shim-review/blob/fedora-28/jforbes.pub

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
The code is exactly https://github.com/rhboot/shim/tree/15 .
The packaging is at https://src.fedoraproject.org/rpms/shim-unsigned-x64/branch/f28

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
None.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It's built on a fedora-28 (beta) host.  Basically:

1. Install from http://download.fedoraproject.org/fedora/linux/development/28/Server/x86_64/iso/Fedora-Server-dvd-x86_64-28-20180409.n.0.iso
2. Install the dependencies: dnf builddep shim-unsigned-x64
3. Rebuild: rpmbuild --rebuild shim-unsigned-x64-15-1.fc28.src.rpm
4. Unpack the resulting rpms to compare them:
   rpm2cpio shim-unsigned-x64-15-1.fc28.x86_64.rpm | cpio -div
   rpm2cpio shim-unsigned-ia32-15-1.fc28.x86_64.rpm | cpio -div
5. The shim binaries will be:
   ./usr/share/shim/15-1.fc28/ia32/shimia32.efi
   ./usr/share/shim/15-1.fc28/x64/shimx64.efi

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
build.log is the log from this build.

-------------------------------------------------------------------------------
Put info about what bootloader you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
It's grub2 with the secure-boot patchset that we've been shipping for a long time.  Here's the source repo: https://github.com/rhboot/grub2/tree/fedora-28

-------------------------------------------------------------------------------
Put info about what kernel you're using, including which patches it includes to enforce Secure Boot here:
-------------------------------------------------------------------------------
It's a 4.16.1 based kernel with the well known secure-boot lockdown patchset we've been shipping for a long time.
Here's the packaging repo: https://src.fedoraproject.org/rpms/kernel/branch/f28

