FROM docker://vathpela/shim-rhel-10-x64-20250818-buildroot:latest
COPY shimx64.efi shimx64.efi.orig
COPY shimx64.efi shimx64.efi
COPY post-process-pe ./
RUN wget -O shim-rhel-10-x64-20250818.efi https://github.com/vathpela/shim-review/raw/refs/heads/rhel-10-x64-20250818/shimx64.efi
RUN ./post-process-pe -n -x shimx64.efi
RUN hexdump -Cv shim-rhel-10-x64-20250818.efi > shim-rhel-10-x64-20250818.hex
RUN hexdump -Cv shimx64.efi.orig > orig.hex
RUN hexdump -Cv shimx64.efi > new.hex
RUN echo this should show no differences:
RUN diff -u orig.hex new.hex
RUN echo this should show changes in the 32-bit checksum at 0xd8 and the single bit set at 0xdf
RUN diff -u shim-rhel-10-x64-20250818.hex new.hex || :
RUN echo "              ^^^^^^^^^^^^ checksum ^ NX_COMPAT" >/dev/null
RUN pesign -h -P -i shimx64.efi
RUN sha256sum shimx64.efi
