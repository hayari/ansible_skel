# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "controller" => { :ip => "192.168.121.10", :cpus => 1, :mem => 1024, :boxname => "centos/7", :provider => "virtualbox", :script => "provisioners/install_centos.sh", :playbook => "provisioners/playbook.yml", :rsync => false  },
  "centos1" => {  :ip => "192.168.121.11", :cpus => 1, :mem => 1024, :boxname => "centos/7", :provider => "virtualbox", :script => "provisioners/install_centos.sh", :playbook => "provisioners/playbook.yml", :rsync => false },
#  "centos2" => {  :ip => "192.168.121.12", :cpus => 1, :mem => 1024, :boxname => "centos/7", :provider => "virtualbox", :script => "provisioners/install_centos.sh", :playbook => "provisioners/playbook.yml", :rsync => false },
  "ubuntu" => {  :ip => "192.168.121.13", :cpus => 1, :mem => 1024, :boxname => "ubuntu/bionic64", :provider => "virtualbox", :script => "provisioners/install_ubuntu.sh", :playbook => "provisioners/playbook.yml", :rsync => false },
  "win" => {  :ip => "192.168.121.14", :cpus => 1, :mem => 2048, :boxname => "opentable/win-2012r2-standard-amd64-nocm", :provider => "virtualbox", :script => "provisioners/install_windows.bat", :rsync => false, :forwarded_port_host => "13389", :forwarded_port_guest => "3389", :playbook => "provisioners/playbook_win.yml" }
}
 
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  cluster.each_with_index do |(hostname, info), index|
    config.hostmanager.enabled = false
    #config.hostmanager.manage_host = false
    #config.hostmanager.manage_guest = true
    #config.hostmanager.ignore_private_ip = false
    #config.hostmanager.include_offline = true
    
    config.vm.define hostname do |cfg|
      
      cfg.vm.hostname = hostname
      cfg.hostsupdater.aliases = [hostname]
      cfg.vm.box = "#{info[:boxname]}" || 'virtualbox'
      cfg.hostmanager.aliases = [hostname+ ".example.com",hostname+ ".web.com"]
      cfg.vm.provider :"#{info[:provider]}" do |prov|
        prov.memory = info[:mem] || '512'
        prov.cpus = info[:cpus] || '1'
        prov.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        prov.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        prov.customize ["modifyvm", :id, "--ioapic", "on"]
      end # end provider
      
      unless info[:ip].nil?
        cfg.vm.network "private_network", ip: "#{info[:ip]}" 
      else
        cfg.vm.network "private_network", type: "dhcp"
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

      #cfg.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/mykeys"
      #cfg.vm.provision "file", source: "sshd_config", destination: "/home/vagrant/sshd_config" 
      #cfg.vm.provision "file", source: "ansible.sudo", destination: "/etc/sudoers.d/ansible"
      #cfg.vm.provision :shell, :inline =>"
      #   echo 'Copying public SSH Keys to the vagrant user '
      #   chmod 700 /home/vagrant/.ssh
      #   cat /home/vagrant/.ssh/mykeys >> /home/vagrant/.ssh/authorized_keys
      #   chmod -R 600 /home/vagrant/.ssh/authorized_keys
      #   echo 'Host 192.168.*.*' >> /home/vagrant/.ssh/config
      #   echo 'StrictHostKeyChecking no' >> /home/vagrant/.ssh/config
      #   echo 'UserKnownHostsFile /dev/null' >> /home/vagrant/.ssh/config
      #   chmod -R 600 /home/vagrant/.ssh/config

      #   ", privileged: false
    
    end # end config
  config.vm.provision :hostmanager
  end # end cluster
end
