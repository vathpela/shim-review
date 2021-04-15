Confirm the following are included in your repo, checking each box:

 - [X] completed README.md file with the necessary information
 - [X] shim.efi to be signed
 - [X] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [X] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [X] any extra patches to shim via your own git tree or as files
 - [X] any extra patches to grub via your own git tree or as files
 - [X] build logs
 - [X] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
`https://github.com/vathpela/shim-review/tree/rhel-7-x64-20231201`

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
d5f18a6efcde04f0076eb992abf61365baf0bf8f5ccc0a2a067f44d26b0fd82b  shimx64.efi
$ pesign -h -P -i shimx64.efi
1f1ac3c854489c07e64a54723c436a79cdd2f2acb8a35b93d3773c2937f9f6b6 shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/304 (shim 15.6 for RHEL 7)

