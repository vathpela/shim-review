Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [x] build logs


###### What organization or people are asking to have this signed:
SUSE, https://suse.com/

###### What product or service is this for:
SUSE Linux Enterprice Server 15 SP1

###### What is the origin and full version number of your shim?
It is shim-15, up to https://github.com/rhboot/shim/commit/b3e4d1f7555aabbf5d54de5ea7cd7e839e7bd83d

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Major linux distribution

###### How do you manage and protect the keys used in your SHIM?
The key is installed in a machine with restricted physical and system access.
Shim binaries do not include private portions of the key.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes

###### What is the origin and full version number of your bootloader (GRUB or other)?
`[your text here]` FIXME

###### If your SHIM launches any other components, please provide further details on what is launched
it doesn't

###### How do the launched components prevent execution of unauthenticated code?
GRUB and kernel are patched to enforce Secure Boot.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
`[your text here]` FIXME

###### What changes were made since your SHIM was last signed?
Signing key was changed to ensure no old grub/kernel can be booted

###### What is the hash of your final SHIM binary?
3166ee4ce65d10105deee3a0163e236ac872e2c45652dc1dd78f8ce984463c12 FIXME
