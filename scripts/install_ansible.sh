sudo add-apt-repository ppa:rquillo/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y
#echo localhost > myhosts
#export ANSIBLE_HOSTS=$(pwd)/myhosts
#ansible all -m ping -u ubuntu