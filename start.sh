qemu-system-x86_64 \
   -nic user,model=virtio-net-pci \
   -enable-kvm -m 8192 -smp 8 \
   -device virtio-blk,drive=myhd \
   -drive if=none,file=guix-system.img,id=myhd
