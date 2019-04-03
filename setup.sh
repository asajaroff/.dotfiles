#!/bin/bash
# Curl
echo "Installing curl"
pacman -Syu curl

# ZSH setup
echo "Installing ZSH"
# CURL
echo "Generating symlinks for ~/.zshrc" 
ln -sf ~/.dotfiles/zshrc ~/.zshrc

# vim setup
echo "Creating necesary directories for vim's swapfiles, backupfiles and undodir"
mkdir -p $HOME/.vim/swapfiles $HOME/.vim/swapfiles $HOME/.vim/backupfiles $HOME/.vim/undodir $HOME/.local/bin
echo "Generating symlink to vimrc"
ln -sf ~/.dotfiles/vimrc ~/.vimrc

# Install all needed software
# sudo pacman -Syu npm jre

# Install SRE software
# aws cli
echo "Installing aws cli for Linux"
curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user && pip install awscli --upgrade --user

# aws-iam-authenticator
echo "Installing aws-iam-authenticator"
curl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator -o aws-iam-authenticator
mv aws-iam-authenticator $HOME/.local/bin/aws-iam-authenticator
chmod +x $HOME/.local/bin/aws-iam-authenticator

# kubectl
echo "Installing kubectl"
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# kubens & kubectx
echo "Installing kubens and kubectx"
curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -o kubectx
curl https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -o kubens
chmod +x kube* 
mv kube* $HOME/.local/bin/

# Terraform 
echo "Installing Terraform binary"
curl https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip -o terraform.zip
unzip terraform.zip
chmod +x terraform
mv terraform $HOME/.local/bin/

# sops
echo "Installing mozilla sops"
wget https://github.com/mozilla/sops/releases/download/3.2.0/sops-3.2.0.linux
chmod +x sops-3.2.0.linux
mv sops $HOME/.local/bin/sops

# stern
echo "Installing stern"
wget https://github.com/wercker/stern/releases/download/1.10.0/stern_linux_amd64
chmod +x stern_linux_amd64
mv stern_linux_amd64 $HOME/.local/bin/stern
# Pendientes

# Helm
