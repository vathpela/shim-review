Make sure you have provided the following information:

 - [x] link to your code branch cloned from keybase shim-review repo
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs


###### What organization or people are asking to have this signed:
VMware, https://www.vmware.com/

###### What product or service is this for:
Photon OS, https://vmware.github.io/photon/

###### What is the origin and full version number of your shim?
Released shum-15 tarball.
sha256sum: 473720200e6dae7cfd3ce7fb27c66367a8d6b08233fe63f01aa1d6b3888deeb6 shim-15.tar.bz2

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Photon OS is a Linux distribution being used by VMware customers in a clouds (vSphere, AWS, etc) and on a bare metal. We use shim->grub2->Linux chain for Secure Boot support. It does need to be signed in order to boot the Phorot OS on any device using UEFI CA certificate for Secure Boot.

###### How do you manage and protect the keys used in your SHIM?
It is stored in HSMs which are operating in FIPS 140-2 Level 2 approved mode, only accessible by certain members of the build infrastructure team. They are located in physically secure areas of our datacenters.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
N/A

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
No. We use linux-4.19.y (no lockdown support)

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
Yes
Applied all patches developed on grub_distros keybase repository:
- 1d7f27ac4 efi: Fix use-after-free in halt/reboot path
- 23e68a839 efi: fix some malformed device path arithmetic errors.
- 96bb109e6 emu: make grub_free(NULL) safe
- 45ec6046e lvm: fix two more potential data-dependent alloc overflows
- b49150789 hfsplus: fix two more overflows
- ab80a97eb relocator: Fix grub_relocator_alloc_chunk_align() top memory allocation
- f6253a1f5 script: Avoid a use-after-free when redefining a function during execution
- d04089c8e script: Remove unused fields from grub_script_function struct
- 10498c8ba relocator: Protect grub_relocator_alloc_chunk_align() max_addr against integer underflow
- ebb15735f relocator: Protect grub_relocator_alloc_chunk_addr() input args against integer underflow/overflow
- 8316694c4 tftp: Do not use priority queue
- cd6760b62 multiboot2: Fix memory leak if grub_create_loader_cmdline() fails
- 8da62d818 udf: Fix memory leak
- 98dfa5467 term: Fix overflow on user inputs
- f91e043bd lzma: Make sure we don't dereference past array
- bdc2668c9 json: Avoid a double-free when parsing fails.
- 4d5e2d135 xnu: Fix double free in grub_xnu_devprop_add_property()
- 5d3e84b15 gfxmenu: Fix double free in load_image()
- 482814113 font: Do not load more than one NAME section
- f2bd30b2f iso9660: Don't leak memory on realloc() failures
- 5fb2befbf malloc: Use overflow checking primitives where we do complex allocations
- 48eeedf1e calloc: Use calloc() at most places
- 79e51ab7a calloc: Make sure we always have an overflow-checking calloc() available
- de1c31584 safemath: Add some arithmetic primitives that check for overflow
- 926df817d yylex: Make lexer fatal errors actually be fatal

grub2.spec will be published after embargo lift.

##### Were your old SHIM hashes provided to Microsoft ?
Yes

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
Yes (rotated signing key, old shim is blacklisted)

###### What is the origin and full version number of your bootloader (GRUB or other)?
Released grub-2.04 catched up to commit 6a34fdb76 ("arm: Fix 32-bit ARM handling of the CTR register") using release-to-master.patch

###### If your SHIM launches any other components, please provide further details on what is launched
N/A

###### How do the launched components prevent execution of unauthenticated code?
GRUB is patched to enforce Secure Boot.
Secure Boot enforcing pachset is taken from Fedora 29 and available here:

https://github.com/vmware/photon/tree/master/SPECS/grub2

- 0001-Add-support-for-Linux-EFI-stub-loading.patch
- 0002-Rework-linux-command.patch
- 0003-Rework-linux16-command.patch
- 0004-Add-secureboot-support-on-efi-chainloader.patch
- 0005-Make-any-of-the-loaders-that-link-in-efi-mode-honor-.patch
- 0006-Handle-multi-arch-64-on-32-boot-in-linuxefi-loader.patch
- 0067-Fix-security-issue-when-reading-username-and-passwor.patch
- 0216-Disable-multiboot-multiboot2-and-linux16-modules-on-.patch

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
We use linux-4.19.y. Current patchset and spec files we use are: https://github.com/vmware/photon/tree/master/SPECS/linux.

Set of patches to enforce Secure Boot: https://github.com/vmware/photon/tree/master/SPECS/linux/secure-boot-patches

- 0001-security-integrity-remove-unnecessary-init_keyring-v.patch
- 0002-integrity-Define-a-trusted-platform-keyring.patch
- 0003-integrity-Load-certs-to-the-platform-keyring.patch
- 0004-efi-Add-EFI-signature-data-types.patch
- 0005-efi-Add-an-EFI-signature-blob-parser.patch
- 0006-efi-Import-certificates-from-UEFI-Secure-Boot.patch

###### What changes were made since your SHIM was last signed?
Switch to new certificate.
Version update. Previous shim we last signed was shim-12.

###### What is the hash of your final SHIM binary?
sha256sum: 1c4e140b5467129fcf600c537b1f7662105bf4e2ca48fc9d8745fc3b6e6cf38b  shimx64.efi
