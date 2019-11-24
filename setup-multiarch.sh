#!/bin/bash

tmpDir="/tmp/${scriptName}.$RANDOM.$RANDOM.$RANDOM.$$"
(umask 077 && mkdir "${tmpDir}") || {
    die "Could not create temporary directory! Exiting."
}
logFile="$HOME/Workspace/Logs/${scriptBasename}.log"

case $(uname) in 
    Linux)
        export OS='linux'
        ;;
    Darwin)
        export OS='darwin'
        ;;
esac

function Kuberntes() {
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$OS/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

    export KOPS_VERSION=1.11.1
    curl -LO https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-$OS-amd64
    chmod +x ./kops-$OS-amd64
    sudo mv ./kops-$OS-amd64 /usr/local/bin/kops-$KOPS_VERSION
    sudo ln -sf /usr/local/bin/kops-$KOPS_VERSION /usr/local/bin/kops

    export HELM_VERSION=2.14.1
    curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-$OS-amd64.tar.gz
    tar -zxvf helm-v$HELM_VERSION-$OS-amd64.tar.gz
    sudo mv $OS-amd64/helm /usr/local/bin/helm-$HELM_VERSION
    sudo ln -sf /usr/local/bin/helm-$HELM_VERSION /usr/local/bin/helm
    # helm plugins
    helm plugin install https://github.com/databus23/helm-diff --version master

    export HELMFILE_VERSION=0.44.0
    curl -LO https://github.com/roboll/helmfile/releases/download/v$HELMFILE_VERSION/helmfile_$OS_amd64  
    chmod +x ./helmfile_$OS_amd64
    sudo mv ./helmfile_$OS_amd64 /usr/local/bin/helmfile-$HELMFILE_VERSION
    sudo ln -sf /usr/local/bin/helmfile-$HELMFILE_VERSION /usr/local/bin/helmfile
    return 0

    curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
    chmod +x ./kubectx
    sudo mv ./kubectx /usr/local/bin/kubectx

    curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens 
    chmod +x ./kubens
    sudo mv ./kubens /usr/local/bin/kubens

    # STERN
    https://github.com/wercker/stern/releases/download/1.10.0/stern_${OS}_amd64
}

function FolderStructure {
    mkdir -p ~/.vim/{swapfiles,backupfiles,undodir}
    mkdir -p ~/.local/bin
    mkdir -p ~/Repos/{asajaroff}
    mkdir -p ~/Workspace/{Logs,tmp,minikube}
    return 0
}
function Development() {
    if [ $(which pip3 ) == 0]; then
        pip3 install awscli --user
    else
        die "pip3 is not present in PATH."
}

function InfrastructureAsCode() {
    echo "Nothing here yet."
}

Kuberntes
exit 0