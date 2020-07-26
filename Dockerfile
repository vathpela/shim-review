#FROM docker.io/abychko/rhel-8
FROM fedora:32

COPY rpmmacros /root/.rpmmacros

RUN dnf --nodocs -y --best --allowerasing --disablerepo='*' --enablerepo=fedora --enablerepo=updates install dnf-plugins-core
RUN dnf config-manager --set-disabled '*'
RUN dnf config-manager --set-enabled fedora updates
RUN dnf --nodocs -y --best --allowerasing install @buildsys-build ccache git make popt-devel nss-devel nspr-devel gettext elfutils-libelf-devel make gcc binutils vim-enhanced wget dos2unix
RUN dnf --nodocs -y --best --allowerasing builddep efivar pesign 'shim-unsigned*'

RUN wget https://kojipkgs.fedoraproject.org//packages/shim-unsigned-x64/15.4/2.fc32/src/shim-unsigned-x64-15.4-2.fc32.src.rpm
RUN rpm -ivh shim-unsigned-x64-15.4-2.fc32.src.rpm
RUN sed -i 's/linux32 -B/linux32/g' /builddir/build/SPECS/shim-unsigned-x64.spec
RUN rpmbuild -bb /builddir/build/SPECS/shim-unsigned-x64.spec
COPY shimia32.efi /
COPY shimx64.efi /
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-ia32-15.4-2.fc32.x86_64.rpm  | cpio -diu
RUN rpm2cpio /builddir/build/RPMS/x86_64/shim-unsigned-x64-15.4-2.fc32.x86_64.rpm | cpio -diu
RUN ls -l /*.efi ./usr/share/shim/15.4-2.fc32/*/shim*.efi
RUN hexdump -Cv ./usr/share/shim/15.4-2.fc32/x64/shimx64.efi > built-x64.hex
RUN hexdump -Cv ./usr/share/shim/15.4-2.fc32/ia32/shimia32.efi > built-ia32.hex
RUN hexdump -Cv /shimia32.efi > orig-ia32.hex
RUN hexdump -Cv /shimx64.efi > orig-x64.hex
RUN objdump -j .sbat -s /usr/share/shim/15.4-2.fc32/x64/shimx64.efi
RUN objdump -j .sbat -s /usr/share/shim/15.4-2.fc32/ia32/shimia32.efi
RUN diff -u orig-ia32.hex built-ia32.hex
RUN diff -u orig-x64.hex built-x64.hex
RUN pesign -h -P -i /usr/share/shim/15.4-2.fc32/ia32/shimia32.efi
RUN pesign -h -P -i /shimia32.efi
RUN pesign -h -P -i /usr/share/shim/15.4-2.fc32/x64/shimx64.efi
RUN pesign -h -P -i /shimx64.efi
RUN sha256sum /usr/share/shim/15.4-2.fc32/x64/shimx64.efi /shimx64.efi /usr/share/shim/15.4-2.fc32/ia32/shimia32.efi /shimia32.efi
