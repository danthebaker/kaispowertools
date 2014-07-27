# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
PROJECTS_HOME = ENV['PROJECTS_HOME'] || "../"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision "shell", inline: <<SCRIPT
    # install
SCRIPT

  config.vm.define "node1" do |node|
    node.vm.network "private_network", ip: "192.168.8.120"
    node.vm.network :forwarded_port, guest: 443, host: 443
    node.vm.network :forwarded_port, guest: 80, host: 8080
    node.vm.hostname = "node1"
    if PROJECTS_HOME
      node.vm.synced_folder PROJECTS_HOME, "/srv/projects"
    end
    node.vm.provision "shell", inline: <<SCRIPT

SCRIPT
  end
end