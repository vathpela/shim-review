FROM docker://vathpela/shim-rhel-8.8-20231201-buildroot:latest

# RUN rm /etc/yum.repos.d/CentOS-Media.repo
COPY rpmmacros /root/.rpmmacros
#RUN yum -y --enablerepo=rhel8-gcc update
#RUN yum -y --enablerepo=rhel8-gcc install \
#	wget rpm-build gcc make elfutils-libelf-devel git \
#	gnu-efi gnu-efi-devel openssl openssl-devel pesign
RUN echo 0
RUN wget https://pjones.fedorapeople.org/rhel-8-x64-20231201/shim-unsigned-x64-15.8-2.el8.src.rpm
RUN rpm -ivh shim-unsigned-x64-15.8-2.el8.src.rpm
# RUN yum-builddep -y --enablerepo=PowerTools --enablerepo=Devel --enablerepo=rhel8-gcc /builddir/build/SPECS/shim-unsigned-x64.spec
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.8-2.el8.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.8-2.el8/*/shim*.efi
RUN echo 2
RUN hexdump -Cv ./usr/share/shim/15.8-2.el8/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15.8-2.el8/x64/shimx64.efi
RUN diff -u orig-x64.hex built-x64.hex
RUN pesign -h -P -i /usr/share/shim/15.8-2.el8/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15.8-2.el8/x64/shimx64.efi /shimx64.efi
