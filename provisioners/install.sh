sudo yum  update -y
sudo yum install cockpit
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload
#sudo yum install -y epel-release
#sudo yum  update -y
#sudo yum groupinstall 'development tools' -y
#sudo yum install -y python python-pip python-devel gcc openssl-devel bzip2-devel