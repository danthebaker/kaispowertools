all: basicpackages latestgit nodejs

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

nodejs:
	apt-get install -y python-software-properties make python
	wget -qO /usr/local/bin/nave https://raw.github.com/isaacs/nave/master/nave.sh
	chmod a+x /usr/local/bin/nave
	nave usemain 0.10.29

go:
	add-apt-repository -y ppa:duh/golang
	apt-get update
	apt-get install -y golang