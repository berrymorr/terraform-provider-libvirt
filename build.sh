#!/bin/bash

rm -rvf ./build
rm -rvf ~/.terraform.d/plugins/local-registry/berrymorr/libvirt
docker build -t terraform-provider-libvirt-compiler . && \
docker run --name tf-libvirt-compiler --rm -v $(pwd)/build:/build terraform-provider-libvirt-compiler && \
docker image rm terraform-provider-libvirt-compiler && \
mkdir -p ~/.terraform.d/plugins/local-registry/berrymorr/libvirt/0.0.1/linux_amd64 && \
cp -prv ./build/* ~/.terraform.d/plugins/local-registry/berrymorr/libvirt/0.0.1/linux_amd64/
