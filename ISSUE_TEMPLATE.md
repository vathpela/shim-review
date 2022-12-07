Confirm the following are included in your repo, checking each box:

 - [X] completed README.md file with the necessary information
 - [X] shim.efi to be signed
 - [X] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [X] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [X] any extra patches to shim via your own git tree or as files
 - [X] any extra patches to grub via your own git tree or as files
 - [X] build logs
 - [X] a Dockerfile to reproduce the build of the provided shim EFI binaries

-------------------------------------------------------------------------------
### What is the link to your tag in a repo cloned from rhboot/shim-review?
-------------------------------------------------------------------------------
`https://github.com/vathpela/shim-review/tree/rhel-7-shim-20221207`

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
$ sha256sum shimx64.efi
f5a16ee9836f2138c4b159d2a63a127a03ca7189566ca0ae9c352c40d5fdaaf6  shimx64.efi
$ pesign -P -h -i shimx64.efi
d8fc47a518f004b136e8ea151c7f5582b47213aff4ad5bf2452b76e083c118a5 shimx64.efi

-------------------------------------------------------------------------------
### What is the link to your previous shim review request (if any, otherwise N/A)?
-------------------------------------------------------------------------------
https://github.com/rhboot/shim-review/issues/293
