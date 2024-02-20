RUN echo 4
FROM docker://vathpela/shim-fedora-x64-20231201-buildroot:latest

COPY rpmmacros /root/.rpmmacros
RUN wget https://pjones.fedorapeople.org/fedora-x64-20231201/shim-unsigned-x64-15.8-2.src.rpm
RUN rpm -ivh shim-unsigned-x64-15.8-2.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.8-2.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.8-2/x64/shim*.efi
RUN hexdump -Cv ./usr/share/shim/15.8-2/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15.8-2/x64/shimx64.efi
RUN diff -u orig-x64.hex built-x64.hex
RUN pesign -h -P -i /usr/share/shim/15.8-2/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15.8-2/x64/shimx64.efi /shimx64.efi
