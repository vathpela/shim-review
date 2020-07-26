#FROM docker.io/abychko/rhel-8
FROM centos:centos8

# RUN rm /etc/yum.repos.d/CentOS-Media.repo
RUN echo 24
COPY rpmmacros /root/.rpmmacros
COPY rhel8-gcc.repo CentOS-Linux-AppStream.repo CentOS-Linux-BaseOS.repo CentOS-Linux-Extras.repo /etc/yum.repos.d/

RUN yum -y install wget
RUN wget https://people.redhat.com/~pjones/shim-rhel-8/shim-unsigned-x64-15.4-4.el8_1.src.rpm https://people.redhat.com/~pjones/shim-rhel-8/repo/redhat-release-8.1-3.3.el8.x86_64.rpm
RUN rpm -e centos-linux-release --noscripts --nodeps
RUN rpm -Uvh /redhat-release-8.1-3.3.el8.x86_64.rpm --force
RUN yum -y update
RUN yum -y install --allowerasing \
	gcc make elfutils-libelf-devel git
RUN yum -y install --allowerasing \
	openssl openssl-devel pesign dos2unix
RUN yum -y install rpm-build
RUN yum -y downgrade annobin binutils cpp git-core kernel-headers rpm
RUN yum -y downgrade openssl glibc-headers libcurl gdb-headless make guile
RUN rpm -e acl hardlink hostname
# RUN yum-builddep -y --enablerepo=PowerTools --enablerepo=Devel --enablerepo=rhel8-gcc /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpm -ivh shim-unsigned-x64-15.4-4.el8_1.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -D 'dist .el8_1' -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15.4-4.el8_1.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.4-4.el8_1.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.4-4.el8_1/*/shim*.efi
RUN sha256sum ./usr/share/shim/15.4-4.el8_1/x64/shimx64.efi ./usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi /shimia32.efi /shimx64.efi
RUN hexdump -Cv ./usr/share/shim/15.4-4.el8_1/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15.4-4.el8_1/x64/shimx64.efi
RUN objdump -h /usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi
RUN diff -u orig-ia32.hex built-ia32.hex
RUN diff -u orig-x64.hex built-x64.hex
RUN cmp ./usr/share/shim/15.4-4.el8_1/x64/shimx64.efi /shimx64.efi
RUN cmp ./usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15.4-4.el8_1/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15.4-4.el8_1/x64/shimx64.efi /shimx64.efi /usr/share/shim/15.4-4.el8_1/ia32/shimia32.efi /shimia32.efi
