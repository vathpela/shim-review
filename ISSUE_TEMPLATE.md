Make sure you have provided the following information:

 - [v] link to your code branch cloned from keybase shim-review repo
 - [v] completed README.md file with the necessary information
 - [v] shim.efi to be signed
 - [v] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [v] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 - [v] any extra patches to shim via your own git tree or as files
 - [v] any extra patches to grub via your own git tree or as files
 - [v] build logs


###### What organization or people are asking to have this signed:
Red Hat, Inc.

###### What product or service is this for:
Red Hat Enterprise Linux 7.9

###### What is the origin and full version number of your shim?
https://github.com/rhboot/shim/releases/tag/15
plus a lot of patches cherry picked from master.

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
We're a major bigtime OS vendor

###### How do you manage and protect the keys used in your SHIM?
The keys are in an HSM managed by our PSIRT team, builders talk to it over
https using gssapi for authentication, and each key is authorized for use by
specific tickets, the issuing of which is protected by ACLs for the user, the
package being built, and the build target.

###### Do you use EV certificates as embedded certificates in the SHIM?
No.

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
Yes, for several linux kernel builds.  Yes.  The vendor db is included here as
db.x64.esl, and it includes the certificate redhatsecurebootca5.cer and the
authenticode hashes listed in db.x64.txt

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
None of the following commits are present:
475fb4e8b2f4444d1d7b406ff3a7d21bc89a1e6f
1957a85b0032a81e6482ca4aab883643b8dae06e
612bd01fc6e04c3ce9eb59587b4a7e4ebd6aff35
75b0cea7bf307f362057cc778efe89af4c615354
These kernels do not have that bug.

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
Yes

##### Were your old SHIM hashes provided to Microsoft ?
Yes

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
Affected grub2 signing cert removed from shim, new certificate introduced.
New grub2 builds with CVE fix will be signed with new signing certificate.

###### What is the origin and full version number of your bootloader (GRUB or other)?
grub2-2.02-0.84.el7_9

###### If your SHIM launches any other components, please provide further details on what is launched
It also launches fwupdate-12-6.el7_9.

###### How do the launched components prevent execution of unauthenticated code?
grub2 verifies signatures on booted kernels via shim.  fwupdate does not
include code to launch other binaries, it can only load UEFI Capsule updates.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
See db.x64.txt

###### What changes were made since your SHIM was last signed?
Most of the master branch (basically all but the fraught openssl rebase and the
filesystem rearrangement) is backported here, plus a few patches that have been
proposed as PRs or are currently PR drafts, as well as two workarounds that
will be pushed as a PR on Wednesday.  The last two aren't pushed publicly
yet because they make it too clear what's going on right now IMO.  Each patch
in the src rpm except for the last two has one of the following in its
changelog:

Upstream-commit-id: $COMMITID
Upstream: pr#$PULL_REQUEST_NUMBER

###### What is the hash of your final SHIM binary?
2cad0b454397089723959faafc2db5388c50dfd5c02319703baba6f03654561c  shimia32.efi
24357d13d3cfc29a7e83d86a6bb53fc932461b7d0a653701188d7b427c704fb1  shimx64.efi
