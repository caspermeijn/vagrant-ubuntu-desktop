packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "ubuntu" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-22.04"
  provider     = "virtualbox"
  add_force    = true
}

build {
  name = "ubuntu-desktop-22.04"
  sources = [
    "source.vagrant.ubuntu"
  ]
  provisioner "shell" {
    inline = [
      "sudo dpkg --add-architecture i386",
      "sudo apt update",
      "sudo apt upgrade -y",
      "sudo apt install -y ubuntu-desktop",
      "sudo apt install -y wine32",
      "printf '[daemon]\nAutomaticLoginEnable=True\nAutomaticLogin=vagrant\n' | sudo tee /etc/gdm3/custom.conf",
      "mkdir -p /home/vagrant/.config",
      "echo yes | tee /home/vagrant/.config/gnome-initial-setup-done",
      "gsettings set org.gnome.desktop.screensaver lock-delay 3600",
      "gsettings set org.gnome.desktop.screensaver lock-enabled false",
      "gsettings set org.gnome.desktop.screensaver idle-activation-enabled false"
    ]
  }
}