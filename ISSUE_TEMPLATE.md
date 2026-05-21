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
### Special note!  Read this before you review this!
*******************************************************************************
Note that this is not a new build - this is the shimx64.efi from our previous
review, linked below, with "post-process-pe -n -x shimx64.efi" run on it to set
the NX compatibility bit.  To demonstrate this, the Dockerfile here just
downloads the shim from that review, runs the same thing on it, and shows the
hex dump diffs.  The diff will show the NX compat bit (the lowest order bit at
0xdf) change from 0 to 1, and the 32-bit checksum at 0xd8 will change.

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
https://github.com/vathpela/shim-review/tree/rhel-10-x64-20260521

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
$ sha256sum shimx64.efi
c724b68fa794a9751b2ce57d6a3b645bf8a79b7753e1a9a4b4a4a1d7926215b1  shimx64.efi
$ pesign -h -P -i shimx64.efi
0fc1c9e2e8d3820dda1416e816583ba518bd546a06c9f90aa88a3afcdf55d46a shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/494 (RHEL 10 for x86_64)

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
Same security contacts as before.
