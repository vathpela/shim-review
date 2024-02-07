#FROM docker.io/abychko/rhel-8
FROM docker://vathpela/shim-rhel-7.9-20231201-buildroot:latest

COPY rpmmacros /root/.rpmmacros

RUN echo 0
RUN wget https://pjones.fedorapeople.org/rhel-7-x64-20231201/shim-15.8-3.el7.src.rpm

RUN rpm -ivh shim-15.8-3.el7.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim.spec
RUN rpmbuild -D 'dist .el7' -bb /builddir/build/SPECS/shim.spec
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.8-3.el7.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/*-15.8-3.el7/shim*.efi
RUN sha256sum ./usr/share/shim/x64-15.8-3.el7/shimx64.efi /shimx64.efi
RUN hexdump -Cv ./usr/share/shim/x64-15.8-3.el7/shimx64.efi > built-x64.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/x64-15.8-3.el7/shimx64.efi > built-x64.objdump.txt
RUN objdump -h /shimx64.efi > orig-x64.objdump.txt
RUN diff -u orig-x64.objdump.txt built-x64.objdump.txt || :
RUN diff -u orig-x64.hex built-x64.hex || :
RUN cmp ./usr/share/shim/x64-15.8-3.el7/shimx64.efi /shimx64.efi
RUN pesign -h -P -i /usr/share/shim/x64-15.8-3.el7/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/x64-15.8-3.el7/shimx64.efi /shimx64.efi
