sudo yum  update -y
#sudo yum install cockpit sos -y
#sudo systemctl enable --now cockpit.socket
#sudo firewall-cmd --permanent --zone=public --add-service=cockpit
#sudo firewall-cmd --reload
sudo yum install -y epel-release
sudo yum  update -y
#sudo yum groupinstall 'development tools' -y
#sudo yum install -y python python-pip python-devel gcc openssl-devel bzip2-devel
sudo yum -y install python-pip
sudo yum install -y ansible
# for windows hosts we need winrm python module
sudo pip install "pywinrm>=0.2.2"
