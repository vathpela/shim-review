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
keybase://team/grub2.cve_2021_3695.shim_review/redhat/rhel-8.7-20220601/

-------------------------------------------------------------------------------
### What is the SHA256 hash of your final SHIM binary?
-------------------------------------------------------------------------------
random:~/devel/github.com/shim-review/rhel-8.7-shim-20220601$ for x in shim*.efi ; do sha256sum ${x} ; done
cf6566a19a1c26d055983491f1b590453b2fe392ffd29530945eb811eeda63c9  shimia32.efi
c0c0aa417bfa857388a665d6feb956fe07aa880fbc5669c918aeec1ab7467a3b  shimx64.efi
