#FROM docker.io/abychko/rhel-8
FROM centos:centos7.2.1511

# RUN rm /etc/yum.repos.d/CentOS-Media.repo
COPY rpmmacros /root/.rpmmacros

RUN yum -y install wget
RUN wget https://pjones.fedorapeople.org/rhel-7-shim-20210412/shim-15.4-1.el7.src.rpm https://pjones.fedorapeople.org/rhel-7-shim-20210412/repo/redhat-release-server-7.2-9.el7_2.1.x86_64.rpm
RUN rpm -e centos-release --noscripts --nodeps
RUN rpm -Uvh /redhat-release-server-7.2-9.el7_2.1.x86_64.rpm --force
COPY centos-base.repo centos-extras.repo centos-updates.repo rhel7-gcc.repo /etc/yum.repos.d/
RUN yum -y update
RUN yum -y install \
	gcc gcc-c++ make elfutils-libelf-devel git \
	openssl openssl-devel pesign dos2unix \
	rpm-build vim-enhanced
RUN yum -y downgrade annobin binutils git-core \
		     libcurl curl gdb-headless make guile \
		     basesystem \
		     device-manager device-manager-libs \
		     findutils redhat-rpm-config
RUN yum -y reinstall \
	acl audit-libs basesystem bash binutils bzip2 bzip2-libs \
	ca-certificates chkconfig coolkey coreutils cpio cpp cracklib \
	cracklib-dicts cryptsetup-libs curl cyrus-sasl-lib dbus \
	dbus-libs device-mapper device-mapper-libs diffutils dos2unix \
	dracut dwz elfutils elfutils-libelf elfutils-libs expat file \
	file-libs findutils fipscheck fipscheck-lib gawk \
	gcc gcc-c++ gdb gdbm git glib2 glibc glibc-common glibc-devel \
	glibc-headers gmp gnupg2 grep groff-base gzip hardlink \
	info kernel-headers keyutils-libs keyutils-libs-devel kmod \
	kmod-libs kpartx krb5-devel krb5-libs less libacl libassuan \
	libattr libblkid libcap libcap-ng libcom_err libcom_err-devel \
	libcurl libdb libdb-utils libedit libffi libgcc libgcrypt \
	libgnome-keyring libgomp libgpg-error libidn libmount libmpc \
	libpwquality libselinux libselinux-devel libsemanage libsepol \
	libsepol-devel libssh2 libstdc++ libstdc++-devel libtasn1 \
	libusbx libuser libutempter libuuid libverto libverto-devel \
	libxml2 lua make mpfr ncurses ncurses-base ncurses-libs nspr \
	nss nss-softokn nss-softokn-freebl nss-sysinit nss-tools \
	nss-util openldap opensc openssh openssh-clients openssl \
	openssl-devel openssl-libs p11-kit p11-kit-trust pam patch pcre \
	pcre-devel pcsc-lite pcsc-lite-ccid pcsc-lite-libs perl perl-Carp \
	perl-Encode perl-Error perl-Exporter perl-File-Path perl-File-Temp \
	perl-Filter perl-Getopt-Long perl-Git perl-HTTP-Tiny perl-PathTools \
	perl-Pod-Escapes perl-Pod-Perldoc perl-Pod-Simple perl-Pod-Usage \
	perl-Scalar-List-Utils perl-Socket perl-Storable perl-TermReadKey \
	perl-Text-ParseWords perl-Thread-Queue perl-Time-HiRes \
	perl-Time-Local perl-constant perl-libs perl-macros perl-parent \
	perl-podlators perl-srpm-macros perl-threads perl-threads-shared \
	pesign pinentry pkgconfig popt procps-ng pth python python-libs \
	qrencode-libs readline redhat-release-server redhat-rpm-config rpm \
	rpm-build rpm-build-libs rpm-libs rsync sed setup shadow-utils \
	shared-mime-info sqlite systemd systemd-libs tar tzdata unzip \
	ustr util-linux vim-common vim-filesystem which xz xz-libs \
	zip zlib zlib-devel
RUN rpm -e bind-license dbus-glib dbus-python gobject-introspection \
	   gpg-pubkey-f4a80eb5-53a7ff4b gpgme gpm-libs hostname \
	   iputils libss passwd pygobject3-base pygpgme pyliblzma \
	   python-iniparse python-pycurl python-urlgrabber pyxattr \
	   rootfiles rpm-python vim-enhanced vim-minimal wget \
	   yum yum-metadata-parser yum-plugin-fastestmirror
RUN rpm -ivh shim-15.4-1.el7.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim.spec
RUN rpmbuild -D 'dist .el7' -bb /builddir/build/SPECS/shim.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15.4-1.el7.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.4-1.el7.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/*-15.4-1.el7/shim*.efi
RUN sha256sum ./usr/share/shim/x64-15.4-1.el7/shimx64.efi ./usr/share/shim/ia32-15.4-1.el7/shimia32.efi /shimia32.efi /shimx64.efi
RUN hexdump -Cv ./usr/share/shim/x64-15.4-1.el7/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/ia32-15.4-1.el7/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/ia32-15.4-1.el7/shimia32.efi > built-ia32.objdump.txt
RUN objdump -h /usr/share/shim/x64-15.4-1.el7/shimx64.efi > built-x64.objdump.txt
RUN objdump -h /shimia32.efi > orig-ia32.objdump.txt
RUN objdump -h /shimx64.efi > orig-x64.objdump.txt
RUN diff -u orig-ia32.objdump.txt built-ia32.objdump.txt || :
RUN diff -u orig-x64.objdump.txt built-x64.objdump.txt || :
RUN diff -u orig-ia32.hex built-ia32.hex || :
RUN diff -u orig-x64.hex built-x64.hex || :
RUN cmp ./usr/share/shim/x64-15.4-1.el7/shimx64.efi /shimx64.efi
RUN cmp ./usr/share/shim/ia32-15.4-1.el7/shimia32.efi /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/ia32-15.4-1.el7/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/x64-15.4-1.el7/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/x64-15.4-1.el7/shimx64.efi /shimx64.efi /usr/share/shim/ia32-15.4-1.el7/shimia32.efi /shimia32.efi
