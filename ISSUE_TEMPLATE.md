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
`https://github.com/vathpela/shim-review/tree/rhel-8-x64-20231201`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
c0721ea8618b2a3e8c26b5f542ad002a60446382aee084932d8ea52ed92d7913  shimx64.efi
$ pesign -h -P -i shimx64.efi
4f410e8b19746ca210b921ad2b7b3937ea49b62b29fdbfcf3b8a84d7d7ddf42a shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
I think it may be https://github.com/rhboot/shim-review/issues/232 (for shim-15.5ish)

