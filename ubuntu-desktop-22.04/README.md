# Vagrant box for Ubuntu Desktop 22.04

https://app.vagrantup.com/caspermeijn/boxes/ubuntu-desktop-22.04

## Prerequisites

```bash
sudo dnf config-manager --add-repo https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install packer vagrant VirtualBox-7.0 kernel-headers kernel-devel dkms
sudo /sbin/vboxconfig
```

## Disable KVM

I got error message `VERR_SVM_IN_USE` and had to unload `kvm` module:

```bash
sudo rmmod kvm_amd kvm
```

## Build box

```bash
packer init .
packer fmt .
packer validate .
vagrant box update --box bento/ubuntu-22.04 --provider virtualbox
packer build .
```

## Test built box

```bash
vagrant box add --force output-ubuntu/package.box --name local/ubuntu-desktop-22.04
vagrant init local/ubuntu-desktop-22.04
vagrant up --provider virtualbox
```

## Upload box

Upload `output-ubuntu/package.box` to https://app.vagrantup.com/caspermeijn/boxes/ubuntu-desktop-22.04

## Cleanup 

```bash
vagrant destroy
rm -rf .vagrant/ output-ubuntu/ Vagrantfile 
```
