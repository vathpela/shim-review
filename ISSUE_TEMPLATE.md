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
https://github.com/vathpela/shim-review/tree/rhel-9-x64-20260521

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
c027843ac34eb5c0a06459a9bbd2f70db8f9fa92e194c9d0184780905a3b4902  shimx64.efi
$ pesign -h -P -i shimx64.efi
8e8f65420b6d5f1f782887ed648659cd1f82c2963db7c30673af628e376bf2b8 shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/493 (RHEL 9 for x86_64)

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
Same security contacts as before.
