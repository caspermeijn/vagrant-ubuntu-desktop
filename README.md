# Vagrant box for Ubuntu Desktop

This box has Ubuntu Desktop and Wine preinstalled. It will auto-login to the desktop with screensaver disabled. Add your own autostart application like [this](https://askubuntu.com/questions/48321/how-do-i-start-applications-automatically-on-login).

https://app.vagrantup.com/caspermeijn/boxes/ubuntu-desktop-22.04

## Prerequisites

```bash
sudo dnf config-manager --add-repo https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install packer vagrant VirtualBox-7.0 kernel-headers kernel-devel dkms
sudo /sbin/vboxconfig
```

## Build box

```bash
packer init .
packer fmt .
packer validate .
packer build .
```

## Test built box

```bash
vagrant init output-ubuntu/package.box
vagrant up --provider virtualbox
```

## Upload box

Upload `output-ubuntu/package.box` to https://app.vagrantup.com/caspermeijn/boxes/ubuntu-desktop-22.04
