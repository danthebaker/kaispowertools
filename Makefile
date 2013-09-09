developer: latestgit watch npmmodules

all: basicpackages firewall zeromq redis mongo digger mon

basicpackages:
	apt-get install -y python-software-properties make python g++

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
	git config --global alias.add-commit '!git add -A && git commit'

zeromq:
	apt-get install -y python-software-properties make python
	add-apt-repository -y ppa:chris-lea/zeromq
	apt-get update
	apt-get install -y libzmq3 libzmq3-dev

nodejs:
	@wget -O - http://nodejs.org/dist/v0.8.23/node-v0.8.23-linux-x64.tar.gz | tar -C /usr --strip-components=1 -zxv
	@#apt-get install -y python-software-properties make python
	@#add-apt-repository -y ppa:chris-lea/node.js
	@#apt-get update
	@#apt-get install -y nodejs

npmmodules:
	npm install component browserify uglify-js uglifycss -g

redis:
	apt-get -y install redis-server

mongo:
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list
	apt-get update
	apt-get install -y mongodb-10gen

# from https://help.github.com/articles/generating-ssh-keys
makekeys:
	ssh-keygen -t rsa

digger: nodejs
	npm install -g digger

hipache: nodejs
	npm install -g hipache

mon:
	(mkdir /tmp/mon && cd /tmp/mon && curl -L# https://github.com/visionmedia/mon/archive/master.tar.gz | tar zx --strip 1 && make install)
	(mkdir /tmp/mongroup && cd /tmp/mongroup && curl -L# https://github.com/jgallen23/mongroup/archive/master.tar.gz | tar zx --strip 1 && make install)

watch:
	rm -rf ~/watch
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install

firewall:
	mkdir -p /etc/firewall
	mkdir -p /etc/firewall/custom
	cd ~ && test -d iptables-boilerplate || git clone ${FIREWALL_REPO}
	cp ~/iptables-boilerplate/firewall /etc/init.d/firewall
	cp ~/iptables-boilerplate/etc/firewall/*.conf /etc/firewall
	chmod 755 /etc/init.d/firewall
	update-rc.d firewall defaults
	# create a backup of the firewall rules and allow 22 and 80 and 443 through
	cp /etc/firewall/services.conf /etc/firewall/services.default.conf
	cat /etc/firewall/services.default.conf | sed -r 's/#((80|443)\/(tcp|udp))/\1/' > /etc/firewall/services.conf
	cp /etc/firewall/firewall.conf /etc/firewall/firewall.default.conf
	cat /etc/firewall/firewall.default.conf | sed -r 's/ipv4_forwarding=false/ipv4_forwarding=true/' > /etc/firewall/firewall.conf
	service firewall restart