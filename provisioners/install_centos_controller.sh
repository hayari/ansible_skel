sudo yum  update -y
#sudo yum install cockpit sos -y
#sudo systemctl enable --now cockpit.socket
#sudo firewall-cmd --permanent --zone=public --add-service=cockpit
#sudo firewall-cmd --reload
sudo yum install -y epel-release
sudo yum  update -y
#sudo yum groupinstall 'development tools' -y
#sudo yum install -y python python-pip python-devel gcc openssl-devel bzip2-devel

pip install --upgrade pip
sudo yum install -y ansible
# for windows hosts we need winrm python module
sudo pip install pywinrm

# install foreman

#sudo yum -y install https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
#sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#sudo yum -y install https://yum.theforeman.org/releases/2.1/el7/x86_64/foreman-release.rpm
#sudo yum -y install foreman-release-scl
#sudo yum -y install foreman-installer
#sudo foreman-installer -v

# install Ansible AWX (Tower Upstream)
sudo yum install -y python3
yum install gcc openssl-devel bzip2-devel libffi-devel -y
sudo yum install -y git make yum-utils curl
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo pip install docker
sudo systemctl enable docker
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo  pip install docker-compose
ansible-galaxy collection install community.general
curl -sL https://rpm.nodesource.com/setup_15.x | sudo bash - 
sudo yum install -y nodejs
sudo yum install -y gcc-c++ 
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum install -y yarn
sudo npm install npm@latest -g

git clone https://github.com/ansible/awx.git
cd awx/installer/
ansible-playbook -i inventory install.yml



