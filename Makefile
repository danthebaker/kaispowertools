developer: latestgit ab watch nodejs npmmodules

all: basicpackages

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
	apt-get install -y python-software-properties make python
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get update
	apt-get install -y nodejs
	rm -rf /usr/local/node
	ln -s /usr/local/nodejs /usr/local/node

ab:
	apt-get install -y apache2-utils

npmmodules:
	npm install component browserify uglify-js uglifycss -g
	rm -rf /home/vagrant/tmp

watch:
	rm -rf ~/watch
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install