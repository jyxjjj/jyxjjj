#!/bin/zsh

cp -i ~/www/wwwroot/Git/user/.zshrc ~/.zshrc
cp -i ~/www/wwwroot/Git/user/zshrc.d/* ~/zshrc.d

cp -i ~/www/wwwroot/Git/user/.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf 
cp -i ~/www/wwwroot/Git/user/.gnupg/gpg.conf ~/.gnupg/gpg.conf 
cp -i ~/www/wwwroot/Git/user/.gnupg/dirmngr.conf ~/.gnupg/dirmngr.conf 

cp -i ~/www/wwwroot/Git/user/.ssh/config ~/.ssh/config 

cp -i ~/www/wwwroot/Git/user/.gitconfig ~/.gitconfig 

cp -i ~/www/wwwroot/Git/user/nvm/default-packages ~/www/nvm/default-packages
cp -i ~/www/wwwroot/Git/user/.npmrc ~/.npmrc

cp -i ~/www/wwwroot/Git/user/JetBrains/* ~/www/JetBrains
