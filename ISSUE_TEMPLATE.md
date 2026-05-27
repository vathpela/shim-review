Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
https://github.com/vathpela/shim-review/tree/fedora-x64-20260527

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
461fd4312a048ce1f81e2a913cd59264fb39aeef4da660a9128420d16a9e3323  shimx64.efi
$ pesign -h -P -i shimx64.efi
ed7f7139df77a5920db5777c773fb1b02a7d27bdfafa6e0114c3a5a19488d1a2 shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/496 (fedora for x86_64)

Note that this is a rebuild of that same version with the NX compat flag set.

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
Same security contacts as before.
