ssh-keygen -f "/home/hichem/.ssh/known_hosts" -R "server1"
ssh-keygen -R server1
rm -rf .git
sed -i '11d' ~/.ssh/known_hosts