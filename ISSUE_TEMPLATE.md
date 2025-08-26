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
https://github.com/vathpela/shim-review/tree/rhel-8.4-x64-20260518

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
331431b5dd398ccfcaf33bf6e0f3d3c4e475d85c3b1e0737b2e63e39bb7d9d82  shimx64.efi
$ sha256sum shimx64.nx.efi
d59069663e553d8f0674087263fd18eb16e8129d0707b0a99e88f2b7acfdc4df  shimx64.nx.efi
$ pesign -h -P -i shimx64.efi
d8a2cf11f73b57aa76a8bd47951774a0bca5d1a72c69b6356c7193216886f1c8 shimx64.efi
$ pesign -h -P -i shimx64.nx.efi
880ab275c3466ca056245dea89d85db5c8d382f454b0c67b7546708098ef9d84 shimx64.nx.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/374 (shim 15.8 for RHEL 8 x64)

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
Same security contacts as before.
