developer: latestgit nodejs watch

# updates to the latest git so we can use password caching
latestgit:
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

nodejs:
	apt-get install -y python-software-properties make
	add-apt-repository -y ppa:chris-lea/node.js
	apt-get update
	apt-get install -y nodejs

npmmodules:
	npm install component -g

watch:
	cd ~ && git clone https://github.com/visionmedia/watch.git
	cd ~/watch && make install