# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "master" => { :ip => "192.168.121.10", :cpus => 1, :mem => 512, :boxname => "centos/7", :provider => "libvirt", :playbook => "provisioners/playbook.yml", :script => "provisioners/install.sh" },
  "slave" => { :ip => "192.168.121.11", :cpus => 1, :mem => 512, :boxname => "centos/7", :provider => "libvirt", :playbook => "provisioners/playbook.yml", :script => "provisioners/install.sh" }
}
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|
      cfg.vm.network :private_network, ip: "#{info[:ip]}"
      cfg.vm.hostname = hostname
      cfg.hostsupdater.aliases = [hostname]
      cfg.vm.box = "#{info[:boxname]}"
      cfg.vm.provider :"#{info[:provider]}" do |vb|
        vb.memory = info[:mem]
        vb.cpus = info[:cpus]
      end # end provider
      cfg.vm.provision "shell" do |shell|
        shell.path  = "#{info[:script]}"
      end # end shell provisioner
      cfg.vm.provision "ansible" do |ansible|
        ansible.playbook  = "#{info[:playbook]}"
      end # end Ansible provisioner
      cfg.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/mykeys"
      cfg.vm.provision :shell, :inline =>"
         echo 'Copying public SSH Keys to the VM'
         chmod 700 /home/vagrant/.ssh
         cat /home/vagrant/.ssh/mykeys >> /home/vagrant/.ssh/authorized_keys
         chmod -R 600 /home/vagrant/.ssh/authorized_keys
         echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
         echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
         echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
         chmod -R 600 /home/vagrant/.ssh/config
         ", privileged: false

    end # end config

  end # end cluster
end