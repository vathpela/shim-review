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
keybase://team/grub2.cve_2021_3695.shim_review/redhat/rhel-9.1-20220601/

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
random:~/devel/github.com/shim-review/rhel-8.6-shim-20220309$ sha256sum shimx64.efi
f4e61a534c5163b1bd0bece983fd7fcdd4460fbf4e8b209e6d2acab40442e7c4  shimx64.efi

random:~/devel/github.com/shim-review/rhel-8.6-shim-20220309$ pesign -P -h -i shimx64.efi
shimx64.efi 5af24fa7419a5bb4cebe934221c3155cb3918773c5b7033d59cddda344f3ebf5
