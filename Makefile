developer: latestgit watch redis mongo nodejs npmmodules

# updates to the latest git so we can use password caching
latestgit: 
	apt-get install -y python-software-properties make python
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

watch:
	rm -rf ~/watch
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install