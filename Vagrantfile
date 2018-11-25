# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "server1" do |server1|
    server1.vm.box = "centos/7"
    server1.vm.network "private_network", ip: "192.168.56.6"
    server1.vm.hostname = "server1.example.com"
    server1.hostsupdater.aliases = ["server1", "server1.example.com"]

        server1.vm.provision "ansible" do |ansible|
          ansible.playbook  = "playbook.yml"

        end
        server1.vm.provider "virtualbox" do |v|
          v.memory = 1024
          v.cpus = 1
        end
  end
end
