# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
PROJECTS_HOME = ENV['PROJECTS_HOME'] || "../"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "192.168.8.120"
  config.vm.network :forwarded_port, guest: 443, host: 443
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.hostname = "node1"
  if PROJECTS_HOME
    config.vm.synced_folder PROJECTS_HOME, "/srv/projects"
  end
  config.vm.provision "shell", inline: <<SCRIPT
cd /vagrant && make all
killall ruby puppet
SCRIPT
end