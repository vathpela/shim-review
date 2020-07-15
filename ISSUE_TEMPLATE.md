Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs


###### What organization or people are asking to have this signed:
Ubuntu

###### Version of shim:
shim 15-based snapshot, up to commit 3beb971

###### Sysdev Submission ID:

###### What product or service is this for:
Ubuntu

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
This is a well-known Linux distro.

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
The new `vendor_db` functionality is not used

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
Yes

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
Yes

##### Were your old SHIM hashes provided to Microsoft ?
Yes, and they are to remain valid.
The CA certificate included in our shims to remain valid and unchanged.
We have submitted to revoke the intermediate certificate that was used
to sign vulnerable grubs.
A new intermediate certificate will be used to sign fixed grubs.

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
No.

Our existing strategy of only including CA certificate in the shim,
and using intermediate certs for signing allows for out-of-band
revocation, without revoking or changing shis.
