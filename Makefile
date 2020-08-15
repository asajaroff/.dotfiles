default: conky yq docker

vscode: vscode-config 
shell: bash-profile

bash-profile:
	if [ -e ${HOME}/.profile ]; then \
		echo 'Bash profile already present.' ;\
		echo 'Renaming to ~/.profile.original...' ;\
		mv ${HOME}/.profile ${HOME}/.profile.original ;\
		fi;
	ln -s ${PWD}/config/bashrc ${HOME}/.bashrc

conky:
	sudo apt install conky-all -y
	echo ln -s ${HOME}/.dotfiles/config/conky.conf ${HOME}/.config/conky/conky.conf

yq:
	sudo add-apt-repository ppa:rmescandon/yq -y
	sudo apt update
	sudo apt install yq -y

docker-install:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	sudo apt-get update
	sudo apt-get -y -o Dpkg::Options::="--force-confnew" install docker-ce
	mkdir -p ~/.docker/cli-plugins
	curl -L https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
	chmod 755 ~/.docker/cli-plugins/docker-buildx
	docker buildx create --name builder --use 

ubuntu-packages:
	sudo apt install curl httpie build-essential dnsutils net-tools neovim jq -y \
	
kubernetes-tools:
	curl -LO https://storage.googleapis.com/kubernetes-release/release/$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl-v
	curl -LO https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64
	sudo chmod +x stern_linux_amd64
	sudo mv stern_linux_amd64 /usr/local/bin/stern

# Git Related configuration
#
#

git-gitignore:
	cat ${PWD}/git/*.gitignore > ${PWD}/git/gitignore_global_rendered
	git config --global core.excludesfile ${PWD}/git/gitignore_global_rendered

# Editors
#
# Vim
vim: vim-plugged
vim-plugged:
	sh -c 'curl -fLo "${$HOME}.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
