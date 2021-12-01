# guix

## inside vm

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
