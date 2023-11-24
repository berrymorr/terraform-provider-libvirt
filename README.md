# Disable SPICE for terraform kvm libvirt provider
## terraform-provider-libvirt
see https://github.com/dmacvicar/terraform-provider-libvirt

This repo is only tools collection for building original terraform's libvirt provider, but with default enabled VNC instead of SPICE.
SPICE is obsoletted and not supported since QEMU 7.2. See https://access.redhat.com/solutions/5414901 .
So, this repo is existing just to answer one question: ***How to disable SPICE for terraform libvirt provider***

## Usage:
First of all, this patch was created for 0.7.6 upstream version. It was also tested on v0.6.14 and works ok, but in other cases you maybe should modify the patch.

Next, if running compiled binary gives you errors like "version GLIBC_2.32 not found" (or running terraform plan/apply gives you non-informative errors about the plugin), you should choose the golang docker image tag between *1.16* and *latest* in Dockerfile. 1.16 is the least, no matter that *1.13* is in go.mod file in upstream repo. Use Dockerfile.bullseye as example for debian bullseye.

For the rest, running build.sh the same as terraform's user should be enough to:
1. Clone upstream repo
1. Apply the patch
1. Compile the libvirt provider
1. Copy it to your local tf plugin storage (~/.terraform.d/plugins/local-registry/berrymorr/libvirt/0.0.1/linux_amd64)
1. Clean all temporary stuff

Now you only need to fix your manifest to use local version of the provider (notice path above) to:
> terraform {
>   required_providers {
>     libvirt = {source = "local-registry/berrymorr/libvirt"}
> }}

And use terraform init/apply as usual - all your VMs now will listen to VNC on 127.0.0.1:59XX instead of annoying useless SPICE!

