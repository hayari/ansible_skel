# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  #"master" => { :ip => "192.168.121.10", :cpus => 1, :mem => 512, :boxname => "centos/7", :provider => "libvirt", :playbook => "provisioners/playbook.yml", :script => "provisioners/install.sh" },
  "slave" => {  :ip => "192.168.121.11", :cpus => 1, :mem => 1024, :boxname => "centos/7", :provider => "libvirt", :forwarded_port_host => "8080", :forwarded_port_guest => "80", :script => "provisioners/install.sh", :rsync => false }
}
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|
      
      cfg.vm.hostname = hostname
      cfg.hostsupdater.aliases = [hostname]
      cfg.vm.box = "#{info[:boxname]}" || 'virtualbox'

      cfg.vm.provider :"#{info[:provider]}" do |prov|
        prov.memory = info[:mem] || '512'
        prov.cpus = info[:cpus] || '1'
      end # end provider
      
      unless info[:ip].nil?
        cfg.vm.network "private_network", ip: "#{info[:ip]}" 
      end 
      unless info[:forwarded_port_host].nil? || info[:forwarded_port_guest].nil?
        cfg.vm.network "forwarded_port", guest: "#{info[:forwarded_port_guest]}", host: "#{info[:forwarded_port_host]}"
      end
      # end network 

      unless info[:rsync].nil?
        cfg.gatling.rsync_on_startup = info[:rsync]
      end # enable disable rsync on startup

      unless info[:script].nil?
        cfg.vm.provision "shell" do |shell|
          shell.path  = "#{info[:script]}"
        end 
      end # end shell provisioner
      
      unless info[:playbook].nil?
        cfg.vm.provision "ansible" do |ansible|
          ansible.playbook  = "#{info[:playbook]}"
        end 
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