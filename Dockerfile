FROM docker.io/centos:7

COPY rhel-7.7-shim-build-deps.repo /etc/yum.repos.d/
RUN yum update -y
RUN yum install -y binutils gcc gnu-efi gnu-efi-devel make redhat-rpm-config-9.1.0-87.el7 rpm-build yum-utils wget rcs
COPY shim.spec /builddir/build/SPECS/
RUN yum-builddep -y /builddir/build/SPECS/shim.spec
COPY 0001-Make-sure-that-MOK-variables-always-get-mirrored.patch /builddir/build/SOURCES/
COPY 0002-mok-fix-the-mirroring-of-RT-variables.patch /builddir/build/SOURCES/
COPY 0003-mok-consolidate-mirroring-code-in-a-helper-instead-o.patch /builddir/build/SOURCES/
COPY 0004-Make-VLogError-behave-as-expected.patch /builddir/build/SOURCES/
COPY 0005-Once-again-try-even-harder-to-get-binaries-without-t.patch /builddir/build/SOURCES/
COPY rpmmacros /root/.rpmmacros
COPY shim-find-debuginfo.sh /builddir/build/SOURCES/shim-find-debuginfo.sh
COPY securebootca.cer /builddir/build/SOURCES/
WORKDIR /builddir/build/
RUN wget https://github.com/rhboot/shim/releases/download/15/shim-15.tar.bz2 -O /builddir/build/SOURCES/shim-15.tar.bz2
RUN rpmbuild -ba /builddir/build/SPECS/shim.spec --noclean
ENV TZ EST5EDT
RUN sha256sum /builddir/build/BUILDROOT/shim-*/usr/share/shim/*/shim{ia32,x64}*.efi
