KOPS_VERSION=1.15.3
# KUBECTL_VERSION=(shell curl )
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

bash-completions:
	curl -LO https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	curl -LO https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	mkdir -p ${HOME}/.config/opt
	mv git-completion.bash ${HOME}/.config/opt/
	mv git-prompt.sh ${HOME}/.config/opt

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
	
# Cloud Tools
#
#

cloud-tools: awscli kubectl kops terraform
awscli:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
	unzip awscliv2.zip \
	sudo ./aws/install 

kubectl:
	curl -LO https://storage.googleapis.com/kubernetes-release/release/$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	sudo chmod +x kubectl && sudo mv kubectl /usr/local/bin/kubectl-v \
	curl -LO https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 \
	sudo chmod +x stern_linux_amd64 \
	sudo mv stern_linux_amd64 /usr/local/bin/stern

kops:
	curl -LO https://github.com/kubernetes/kops/releases/download/v$(KOPS_VERSION)/kops-linux-amd64
	chmod +x kops-linux-amd64
	sudo mv kops-linux-amd64 /usr/local/bin/kops-$(KOPS_VERSION)
	sudo ln -sf /usr/local/bin/kops-$(KOPS_VERSION) /usr/local/bin/kops

terraform:
	curl -LO https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip
	unzip terraform_0.13.0_linux_amd64.zip
	sudo mv terraform_0.13.0_linux_amd64.zip /usr/local/bin/terraform-v0.13.0
	sudo ln -sf /usr/local/bin/terraform-v0.13.0 /usr/local/bin/terraform

# Git Related configuration
#
#

git-gitignore:
	cat ${PWD}/git/*.gitignore > ${PWD}/git/gitignore_global_rendered
	git config --global core.excludesfile ${PWD}/git/gitignore_global_rendered

# Editors
#
# Vim

vim:
	mkdir -p ${HOME}/.vim/undodir
	mkdir -p ${HOME}/.vim/swapfiles
	mkdir -p ${HOME}/.vim/backupfiles
	ln -sf ${PWD}/vimrc ~/.vimrc

vim-plugged:
	sh -c 'curl -fLo "${$HOME}.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
