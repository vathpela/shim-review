FROM docker://fedora:35

COPY rpmmacros /root/.rpmmacros
RUN dnf install -y dnf-plugins-core wget
RUN wget https://pjones.fedorapeople.org/5913cd510f772de4e29a7390b7f16cbcc402122c8f1140323e14cb7d085182ea/shim-unsigned-x64-15.6-1.src.rpm
RUN rpm -ivh shim-unsigned-x64-15.6-1.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN dnf builddep -y shim-unsigned-x64-15.6-1.src.rpm
RUN dnf install -y @buildsys-build
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.6-1.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.6-1/*/shim*.efi
RUN hexdump -Cv ./usr/share/shim/15.6-1/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -h /usr/share/shim/15.6-1/x64/shimx64.efi
RUN diff -u orig-x64.hex built-x64.hex
RUN for x in /usr/share/shim/15.6-1/x64/shimx64.efi /shimx64.efi ; do pesign -h -P -i ${x} ; done
RUN sha256sum /usr/share/shim/15.6-1/x64/shimx64.efi /shimx64.efi
