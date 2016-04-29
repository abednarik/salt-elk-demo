# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :monitor do |monitor_config|
    monitor_config.vm.box = "ubuntu/trusty64"
    monitor_config.vm.host_name = 'monitor'
    monitor_config.vm.network "private_network", ip: "192.168.50.10"
    monitor_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    monitor_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"
    monitor_config.vm.network "forwarded_port", guest: 5601, host: 5601

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end

    monitor_config.vm.provision :salt do |salt|
      salt.minion_config = "saltstack/etc/minion"
      salt.master_config = "saltstack/etc/master"
      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = false
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :client do |client_config|
    client_config.vm.box = "freebsd/FreeBSD-10.2-STABLE"
    client_config.vm.host_name = 'client'
    client_config.vm.network "private_network", ip: "192.168.50.11"
    client_config.vm.base_mac = "080027D14C66"
    client_config.ssh.shell = "sh"
    client_config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
    client_config.vm.provision "shell", path: "freebsd_provision.sh"
  end
end
