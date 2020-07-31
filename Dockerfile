FROM centos:centos7

RUN rm /etc/yum.repos.d/CentOS-Media.repo
RUN echo 2
RUN yum -y install wget rpm-build gcc gcc-c++ make yum-utils
RUN wget https://people.redhat.com/~pjones/shim-centos-7/shim-15-8.el7.src.rpm
COPY rpmmacros /root/.rpmmacros
RUN rpm -ivh shim-15-8.el7.src.rpm
RUN yum-builddep -y /builddir/build/SPECS/shim.spec
RUN sed -i 's/^%dist .el7$/%dist .el7_9/g' /etc/rpm/macros.dist
RUN rpmbuild -bb /builddir/build/SPECS/shim.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15-8.el7.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15-8.el7.x86_64.rpm | cpio -diu
RUN ls -l /*.efi /usr/share/shim/*/shim*.efi
RUN hexdump -Cv ./usr/share/shim/x64-15-8.el7/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/ia32-15-8.el7/shimia32.efi > built-x32.hex
RUN hexdump -Cv /shimia32.efi > orig-x32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN diff -u orig-x32.hex built-x32.hex
RUN diff -u orig-x64.hex built-x64.hex
RUN objdump -h /usr/share/shim/x64-15-8.el7/shimx64.efi
RUN objdump -h /usr/share/shim/ia32-15-8.el7/shimia32.efi
RUN pesign -h -P -i /usr/share/shim/ia32-15-8.el7/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/x64-15-8.el7/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum \
	/usr/share/shim/ia32-15-8.el7/shimia32.efi \
	/shimia32.efi \
	/usr/share/shim/x64-15-8.el7/shimx64.efi \
	/shimx64.efi \
