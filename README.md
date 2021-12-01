# guix

## inside vm

https://guix.gnu.org/en/manual/devel/en/guix.html#Installing-Guix-in-a-VM

https://ci.guix.gnu.org/search/latest/ISO-9660?query=spec:images+status:success+system:x86_64-linux+image.iso

```bash
qemu-img create -f qcow2 guix-system.img 50G
qemu-system-x86_64 -m 8192 -smp 8 -enable-kvm \
  -nic user,model=virtio-net-pci -boot menu=on,order=d \
  -drive file=guix-system.img \
  -drive media=cdrom,file=*-image.iso
```

https://guix.gnu.org/en/manual/devel/en/guix.html#Running-Guix-in-a-VM

```bash
qemu-system-x86_64 \
   -nic user,model=virtio-net-pci \
   -enable-kvm -m 8192 -smp 8 \
   -device virtio-blk,drive=myhd \
   -drive if=none,file=guix-system.img,id=myhd
```

ssh moritz@192.168.122.66

use virt-manager to also get networking

https://guix.gnu.org/manual/devel/en/guix.html#Declaring-the-Home-Environment

https://guix.gnu.org/manual/devel/en/guix.html#Invoking-guix-deploy

https://guix.gnu.org/manual/devel/en/guix.html#Bootstrapping

## setup

```bash
sudo guix system reconfigure ~/guix/config.scm
guix home reconfigure ~/guix/home/moritz.scm
ssh-keygen -t ed25519
# create a Github personal access token with repo:public_repo scope
```
