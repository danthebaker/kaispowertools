all: latestgit ab watch nodejs npmmodules

scanchanged:
	./scripts/gitstatus/index.js changed /srv/projects -f ./mymodules.txt
	
basicpackages:
	apt-get install -y python-software-properties makesoftware-properties-common curl python g++

# updates to the latest git so we can use password caching
latestgit: basicpackages
	add-apt-repository ppa:voronov84/andreyv -y
	apt-get update
	apt-get install -y git

# configures git with our details
gitconfig:
	git config --global user.name "${GIT_NAME}"
	git config --global user.email "${GIT_EMAIL}"
	git config --global credential.helper 'cache --timeout=3600'
	git config --global push.default simple
	git config --global alias.ac '!git add -A && git commit'

zeromq:
	apt-get install -y python-software-properties make python
	add-apt-repository -y ppa:chris-lea/zeromq
	apt-get update
	apt-get install -y libzmq3 libzmq3-dev

nodejs:
	apt-get install -y python-software-properties make python
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get update
	apt-get install -y nodejs

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

watch:
	rm -rf ~/watch
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install