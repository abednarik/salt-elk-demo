# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
#!/bin/sh
# Simple script to install and configure salt minion in freebsd

sudo pkg install -y py27-salt || exit 1
sudo cp -v /usr/local/etc/salt/minion.sample /usr/local/etc/salt/minion || exit 1
sudo sed 's/#master: salt/master: 192.168.50.10/' /usr/local/etc/salt/minion || exit 1
sudp sysrc salt_minion_enable="YES" || exit 1
sudo service salt_minion start || exit 1
SCRIPT


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :master do |master_config|
    master_config.vm.box = "ubuntu/trusty64"
    master_config.vm.host_name = 'saltmaster.local'
    master_config.vm.network "private_network", ip: "192.168.50.10"
    master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
    master_config.vm.network "forwarded_port", guest: 5601, host: 5601

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end

    master_config.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion"
      salt.master_config = "saltstack/etc/master"
      salt.master_key = "saltstack/keys/master_minion.pem"
      salt.master_pub = "saltstack/keys/master_minion.pub"
      salt.minion_key = "saltstack/keys/master_minion.pem"
      salt.minion_pub = "saltstack/keys/master_minion.pub"

      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = false
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion1 do |minion_config|
    minion_config.vm.box = "freebsd/FreeBSD-10.2-STABLE"
    minion_config.vm.host_name = 'saltminion1.local'
    minion_config.vm.network "private_network", ip: "192.168.50.11"
    minion_config.vm.base_mac = "080027D14C66"
    minion_config.ssh.shell = "sh"
    minion_config.vm.synced_folder ".", "/vagrant", disabled: true

    config.vm.provision "shell", inline: $script
  end
end
