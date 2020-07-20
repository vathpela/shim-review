Make sure you have provided the following information:

 - [x] link to your code branch cloned from keybase shim-review repo
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs


###### What organization or people are asking to have this signed:
SUSE, https://suse.com/

###### What product or service is this for:
SUSE Linux Enterprice Server 15 SP1

###### What is the origin and full version number of your shim?
It is shim-15, up to https://github.com/rhboot/shim/commit/b3e4d1f7555aabbf5d54de5ea7cd7e839e7bd83d

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Major linux distribution

###### How do you manage and protect the keys used in your SHIM?
The key is installed in a machine with restricted physical and system access.
Shim binaries do not include private portions of the key.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
n/a

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
yes

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
yes

##### Were your old SHIM hashes provided to Microsoft ?
yes

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
yes (rotated signing key, old shims are blacklisted)

###### What is the origin and full version number of your bootloader (GRUB or other)?
upstream grub-2.04 with patches for all currently discussed security issues
(CVE-2020-10713, CVE-2020-14308 CVE-2020-14309, CVE-2020-14310, CVE-2020-14311)
* 0001-yylex-Make-lexer-fatal-errors-actually-be-fatal.patch
* 0002-safemath-Add-some-arithmetic-primitives-that-check-f.patch
* 0003-calloc-Make-sure-we-always-have-an-overflow-checking.patch
* 0004-calloc-Use-calloc-at-most-places.patch
* 0005-malloc-Use-overflow-checking-primitives-where-we-do-.patch
* 0006-iso9660-Don-t-leak-memory-on-realloc-failures.patch
* 0007-font-Do-not-load-more-than-one-NAME-section.patch

###### If your SHIM launches any other components, please provide further details on what is launched
it doesn't

###### How do the launched components prevent execution of unauthenticated code?
GRUB and kernel are patched to enforce Secure Boot.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
5.3.18 +
# Module signing / secure boot
patches.suse/KEYS-Make-use-of-platform-keyring-for-module-signatu.patch

# Lock down functions for UEFI secure boot
patches.suse/0001-security-lockdown-expose-a-hook-to-lock-the-kernel-down.patch
patches.suse/0002-efi-Add-an-EFI_SECURE_BOOT-flag-to-indicate-secure-boot-mode.patch
patches.suse/0003-efi-Lock-down-the-kernel-if-booted-in-secure-boot-mode.patch
patches.suse/0004-efi-Lock-down-the-kernel-at-the-integrity-level-if-b.patch

# Using the hash in MOKx to blacklist kernel module, FATE#316531
patches.suse/0001-MODSIGN-do-not-load-mok-when-secure-boot-disabled.patch
patches.suse/0001-efi-add-a-function-to-convert-the-status-code-to-a-s.patch
patches.suse/0002-efi-show-error-messages-only-when-loading-certificat.patch
patches.suse/0003-MODSIGN-load-blacklist-from-MOKx.patch
patches.suse/0004-MODSIGN-checking-the-blacklisted-hash-before-loading.patch

# Hibernation Signature Verification FATE#316350
patches.suse/0001-security-create-hidden-area-to-keep-sensitive-data.patch
patches.suse/0002-hibernate-avoid-the-data-in-hidden-area-to-be-snapsh.patch
patches.suse/0003-x86-KASLR-public-the-function-for-getting-random-lon.patch
patches.suse/0005-efi-generate-secret-key-in-EFI-boot-environment.patch
patches.suse/0006-efi-allow-user-to-regenerate-secret-key.patch
patches.suse/0007-PM-hibernate-encrypt-hidden-area.patch
patches.suse/0008-PM-hibernate-Generate-and-verify-signature-for-snaps.patch
patches.suse/0009-PM-hibernate-prevent-EFI-secret-key-to-be-regenerate.patch
patches.suse/0010-PM-hibernate-a-option-to-request-that-snapshot-image.patch
patches.suse/0011-PM-hibernate-require-hibernate-snapshot-image-to-be-.patch

###### What changes were made since your SHIM was last signed?
Signing key was changed to ensure no old grub/kernel can not be booted

###### What is the hash of your final SHIM binary?
3166ee4ce65d10105deee3a0163e236ac872e2c45652dc1dd78f8ce984463c12
