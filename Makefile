all: latestgit nodejs npmmodules

scanchanged:
	./scripts/gitstatus/index.js changed /srv/projects -f ./mymodules.txt

simplepackages:
	apt-get install -y python-software-properties

basicpackages:
	apt-get install -y python-software-properties make software-properties-common curl python g++

# updates to the latest git so we can use password caching
latestgit:
	add-apt-repository ppa:voronov84/andreyv -y
	apt-get update
	apt-get install -y git

# configures git with our details
gitconfig: gitshortcuts
	git config --global user.name "${GIT_NAME}"
	git config --global user.email "${GIT_EMAIL}"
	git config --global credential.helper 'cache --timeout=3600'
	git config --global push.default simple

gitshortcuts:
	git config --global alias.ac '!git add -A && git commit'

zeromq:
	apt-get install -y python-software-properties make python
	add-apt-repository -y ppa:chris-lea/zeromq
	apt-get update
	apt-get install -y libzmq3 libzmq3-dev

etcdctl:
	rm -rf /tmp/etcd-v0.3.0-linux-amd64.tar.gz
	curl -L https://github.com/coreos/etcd/releases/download/v0.3.0/etcd-v0.3.0-linux-amd64.tar.gz -o /tmp/etcd-v0.3.0-linux-amd64.tar.gz
	cd /tmp && gzip -dc etcd-v0.3.0-linux-amd64.tar.gz | tar -xof -
	cp -f /tmp/etcd-v0.3.0-linux-amd64/etcdctl /usr/local/bin

nodejs:
	apt-get install -y python-software-properties make python
	wget -qO /usr/local/bin/nave https://raw.github.com/isaacs/nave/master/nave.sh
	chmod a+x /usr/local/bin/nave
	nave usemain 0.10.29

go:
	add-apt-repository -y ppa:duh/golang
	apt-get update
	apt-get install -y golang

docker: aufs
	egrep -i "^docker" /etc/group || groupadd docker
	usermod -aG docker git
	usermod -aG docker quarry
	curl https://get.docker.io/gpg | apt-key add -
	echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
	apt-get update
	apt-get install -y lxc-docker 
	sleep 2 # give docker a moment i guess

quarryfiles:
	test -d ~/quarryfiles || git clone https://github.com/binocarlos/quarryfiles.git ~/quarryfiles	

mongo: docker quarryfiles
	cd ~/quarryfiles && ./builddockerfile mongo
	docker run -d -p 27017:27017 -t quarry/mongo

redis: docker quarryfiles
	cd ~/quarryfiles && ./builddockerfile redis
	docker run -d -p 6379:6379 -t quarry/redis

aufs:
	lsmod | grep aufs || modprobe aufs || apt-get install -y linux-image-extra-`uname -r`

ab:
	apt-get install -y apache2-utils

npmmodules:
	npm install component browserify uglify-js uglifycss -g
	rm -rf /home/vagrant/tmp

phantom:
	apt-get install build-essential chrpath git-core libssl-dev libfontconfig1-dev
	npm install phantomjs -g

watch:
	rm -rf ~/watch
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install