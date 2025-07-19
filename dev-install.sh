#!/bin/sh
sudo apt-get update
sudo apt-get upgrade -y

sudo apt install vim -y
sudo apt install curl -y
sudo apt install chromium-browser -y
sudo apt install git -y
sudo apt install gparted -y

# sops
SOPS_VERSION=$(curl -s "https://api.github.com/repos/getsops/sops/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
SOPS_ARCH=$(dpkg --print-architecture)

if [ "$SOPS_ARCH" = "amd64" ]; then
    SOPS_BINARY="sops-${SOPS_VERSION}.linux.amd64"
elif [ "$SOPS_ARCH" = "arm64" ]; then
    SOPS_BINARY="sops-${SOPS_VERSION}.linux.arm64"
else
    echo "Unsupported architecture for SOPS: $SOPS_ARCH. Please install manually."
    exit 1
fi

curl -LO "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/${SOPS_BINARY}"
sudo mv "${SOPS_BINARY}" /usr/local/bin/sops
sudo chmod +x /usr/local/bin/sops

# sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# nodejs (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts


# docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}
echo "Dev install finished!"
