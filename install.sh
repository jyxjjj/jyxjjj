#!/bin/zsh

# proxies
read proxyip\?"[Proxy] Enter your Socks5 proxy IP (default: 127.0.0.1): "
read proxyport\?"[Proxy] Enter your Socks5 proxy port (default: 7890): "

# verify proxy
if [ -z "$proxyip" ] || [ -z "$proxyport" ]; then
    proxyip=127.0.0.1
    proxyport=7890
fi

# check proxy
if ! curl -fSsL -x "socks5h://$proxyip:$proxyport" "https://www.google.com/generate_204" &>/dev/null; then
    echo "Proxy IP or port is incorrect for Google."
    exit 1
fi
if ! curl -fSsL -x "socks5h://$proxyip:$proxyport" "https://www.gstatic.com/generate_204" &>/dev/null; then
    echo "Proxy IP or port is incorrect for Google Static."
    exit 1
fi
if ! curl -fSsL -x "socks5h://$proxyip:$proxyport" "https://www.cloudflare.com/cdn-cgi/trace" &>/dev/null; then
    echo "Proxy IP or port is incorrect for Cloudflare."
    exit 1
fi
if ! curl -fSsL -x "socks5h://$proxyip:$proxyport" "https://raw.githubusercontent.com" &>/dev/null; then
    echo "Proxy IP or port is incorrect for GitHub."
    exit 1
fi

# set proxy
export http_proxy="http://$proxyip:$proxyport"
export https_proxy="http://$proxyip:$proxyport"
export socks5_proxy="socks5h://$proxyip:$proxyport"
export all_proxy="http://$proxyip:$proxyport"

sudo -v
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

set -e

# detection os
if [ "$(uname -s)" != "Darwin" ]; then
    echo "This script is only for macOS."
    exit 1
fi

# detection arch
if [ "$(uname -m)" != "arm64" ]; then
    echo "This script is only for Apple Silicon Macs."
    exit 1
fi

# system
sudo rm -f /etc/zshrc_Apple_Terminal
if ! xcode-select -p &>/dev/null; then
    xcode-select --install
fi
if ! /usr/bin/pgrep oahd &>/dev/null; then
    softwareupdate --install-rosetta --agree-to-license
fi

# homebrew & php
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew update && brew upgrade
brew tap shivammathur/php
brew tap shivammathur/extensions
brew install git curl wget
brew install shivammathur/php/php \
    shivammathur/php/php@7.3 \
    shivammathur/php/php@7.4 \
    shivammathur/php/php@8.1 \
    shivammathur/php/php@8.2 \
    shivammathur/php/php@8.3 \
    shivammathur/extensions/event@7.3 \
    shivammathur/extensions/event@7.4 \
    shivammathur/extensions/event@8.1 \
    shivammathur/extensions/event@8.2 \
    shivammathur/extensions/event@8.3 \
    shivammathur/extensions/event@8.4 \
    shivammathur/extensions/igbinary@7.3 \
    shivammathur/extensions/igbinary@7.4 \
    shivammathur/extensions/igbinary@8.1 \
    shivammathur/extensions/igbinary@8.2 \
    shivammathur/extensions/igbinary@8.3 \
    shivammathur/extensions/igbinary@8.4 \
    shivammathur/extensions/msgpack@7.3 \
    shivammathur/extensions/msgpack@7.4 \
    shivammathur/extensions/msgpack@8.1 \
    shivammathur/extensions/msgpack@8.2 \
    shivammathur/extensions/msgpack@8.3 \
    shivammathur/extensions/msgpack@8.4 \
    shivammathur/extensions/redis@7.3 \
    shivammathur/extensions/redis@7.4 \
    shivammathur/extensions/redis@8.1 \
    shivammathur/extensions/redis@8.2 \
    shivammathur/extensions/redis@8.3 \
    shivammathur/extensions/redis@8.4

# composer
sudo curl -fSsL https://mirrors.aliyun.com/composer/composer.phar -o /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# vscode
curl -fSsLo ~/Downloads/VSCode.zip "https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64"
unzip ~/Downloads/VSCode.zip -d /Applications/
set +e
ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code /usr/local/bin/code
set -e
# git
git config --global filter.lfs.clean "git-lfs clean -- %f"
git config --global filter.lfs.smudge "git-lfs smudge -- %f"
git config --global filter.lfs.process "git-lfs filter-process"
git config --global filter.lfs.required "true"
git config --global core.eol "lf"
git config --global core.autocrlf "input"
git config --global core.safecrlf "true"
git config --global core.filemode "false"
git config --global core.bare "false"
git config --global core.repositoryformatversion "0"
git config --global core.logallrefupdates "true"
git config --global core.ignorecase "false"
git config --global core.precomposeunicode "true"
git config --global color.ui "auto"
git config --global init.defaultBranch "main"
git config --global pull.rebase "true"
read name\?"[For Git] Enter your name: "
git config --global user.name "$name"
read email\?"[For Git] Enter your email: "
git config --global user.email "$email"

HOSTNAME=$(hostname)

# check git key
read preferred\?"[For SSH] Which type of key do you prefer? (1) RSA (2) ED25519 (default: 2) "
# if user input is empty, use default value, if user input is not 1, use 2
if [ "$preferred" != "1" ]; then
    preferred="ed25519"
else
    preferred="rsa"
fi
if [ "$preferred" = "rsa" ]; then
    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t $preferred -b 4096 -C "$name@$HOSTNAME"
    fi
else
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        ssh-keygen -t $preferred -C "$name@$HOSTNAME"
    fi
fi
# check github access
ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"
if [ $? -ne 0 ]; then
    echo "Please add the following public key to your GitHub account."
    cat ~/.ssh/id_$preferred.pub
    pbcopy <~/.ssh/id_$preferred.pub
    echo "The public key has been copied to the clipboard."
    open https://github.com/settings/ssh/new
    read continue\?"Press [Enter] key to continue..."
fi

# nvm
mkdir -p ~/www/
cd ~/www/
git clone git@github.com:nvm-sh/nvm.git
cd nvm
git fetch --tags
git checkout $(git describe --abbrev=0 --tags)
curl -fSsLo default-packages https://github.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/nvm/default-packages
cd ~

# zsh
curl -fSsLo ~/Library/Preferences/com.apple.Terminal.plist "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/com.apple.Terminal.plist"

mkdir -p ~/zshrc.d/
rm -f ~/zshrc.d/*
rm -f ~/.zprofile
rm -f ~/.zshenv
rm -f ~/.zlogin
rm -f ~/.zlogout
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/.zshrc" -o ~/.zshrc
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/.git-prompt.sh" -o ~/zshrc.d/.git-prompt.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/01.proxy.sh" -o ~/zshrc.d/01.proxy.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/10.git.sh" -o ~/zshrc.d/10.git.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/20.homebrew.sh" -o ~/zshrc.d/20.homebrew.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/30.alias.sh" -o ~/zshrc.d/30.alias.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/31.functions-macos.sh" -o ~/zshrc.d/31.functions-macos.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/32.functions-terminal.sh" -o ~/zshrc.d/32.functions-terminal.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/33.functions-devices.sh" -o ~/zshrc.d/33.functions-devices.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/34.functions-network.sh" -o ~/zshrc.d/34.functions-network.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/40.chrome.sh" -o ~/zshrc.d/40.chrome.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/60.php.sh" -o ~/zshrc.d/60.php.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/61.artisan.sh" -o ~/zshrc.d/61.artisan.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/62.nvm.sh" -o ~/zshrc.d/62.nvm.sh
curl -fSsL "https://raw.githubusercontent.com/jyxjjj/jyxjjj/raw/refs/heads/UserConfigs/zshrc.d/99.chpwd.sh" -o ~/zshrc.d/99.chpwd.sh

set +e
source ~/.zshrc
writedefaults
nvmupdate
