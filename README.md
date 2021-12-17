# guix

create vm with virt-manager (also enable change settings before creation and set bootloader to efi)

https://guix.gnu.org/en/manual/devel/en/guix.html

```
loadkeys de
ip address
passwd
herd start ssh-daemon
```

```
ssh root@192.168.122.92
ls /sys/firmware/efi/
cfdisk
# gpt
# 500M EFI System
# 49.5G Linux filesystem
mkfs.fat -F32 /dev/vda1
mkfs.ext4 -L my-root /dev/vda2
mount LABEL=my-root /mnt
mkdir -p /mnt/boot/efi
mount /dev/vda1 /mnt/boot/efi
herd start cow-store /mnt
mkdir /mnt/etc
nano /mnt/etc/config.scm
guix pull
guix system init /mnt/etc/config.scm /mnt
```

## setup

```bash
sudo guix system reconfigure ~/guix/config.scm
guix home reconfigure ~/guix/home/moritz.scm
ssh-keygen -t ed25519
# create a Github personal access token with repo:public_repo scope
```
