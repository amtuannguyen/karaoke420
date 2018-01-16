# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.define "karaoke420"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8981, host: 8981
  config.vm.network "forwarded_port", guest: 8982, host: 8982
  config.vm.network "forwarded_port", guest: 8983, host: 8983
  config.vm.hostname = "karaoke420.local"
  config.vm.provision :shell, path: "vagrant-provision.sh", privileged: false
  config.ssh.forward_agent = true
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end
  
end

