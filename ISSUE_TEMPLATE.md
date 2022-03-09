Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

-------------------------------------------------------------------------------
### What is the link to your tag in a repo cloned from rhboot/shim-review?
-------------------------------------------------------------------------------
https://github.com/vathpela/shim-review/tree/fedora-35-20220607

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------

random:~/devel/github.com/shim-review/fedora-35-20220607$ sha256sum shimx64.efi
718b637094420a25349f98a6ee2807c7fc67c7a1d8af4cfe3be7369da7c5101c  shimx64.efi

random:~/devel/github.com/shim-review/fedora-35-20220607$ pesign -h -P -i shimx64.efi
shimx64.efi 2d78d880ab1b08b8757b5bdd52104ae1fc38421e22b1e7a18d84e3c6000dc305
