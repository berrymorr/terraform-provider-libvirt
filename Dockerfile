FROM golang:latest

COPY spice2vnc.patch /

RUN apt-get update && \
    apt-get install -y libvirt-dev patch && \
    git clone https://github.com/dmacvicar/terraform-provider-libvirt.git /terraform-provider-libvirt && \
    cd /terraform-provider-libvirt && git checkout v0.7.6 && patch -p1 < /spice2vnc.patch

WORKDIR /terraform-provider-libvirt
CMD make && cp terraform-provider-libvirt /build/

