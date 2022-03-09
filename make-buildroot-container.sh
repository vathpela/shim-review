#!/bin/bash

set -eu

if ! grep -q ' /mnt/redhat ' /etc/mtab ; then
    sudo mount /mnt/redhat
fi
podman build -f Dockerfile.buildroot -t shim-rhel-8.6-20220309-buildroot -v /mnt/redhat:/mnt/redhat
podman push "localhost/shim-rhel-8.6-20220309-buildroot:latest" \
            "docker://vathpela/shim-rhel-8.6-20220309-buildroot:latest"

# vim:fenc=utf-8:tw=75
