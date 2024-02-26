#!/bin/zsh

cp -i ~/.zshrc ~/www/wwwroot/Git/user/.zshrc
cp -i ~/zshrc.d/* ~/www/wwwroot/Git/user/zshrc.d

cp -i ~/.gnupg/gpg-agent.conf ~/www/wwwroot/Git/user/.gnupg/gpg-agent.conf
cp -i ~/.gnupg/gpg.conf ~/www/wwwroot/Git/user/.gnupg/gpg.conf
cp -i ~/.gnupg/dirmngr.conf ~/www/wwwroot/Git/user/.gnupg/dirmngr.conf

cp -i ~/.ssh/config ~/www/wwwroot/Git/user/.ssh/config

cp -i ~/.gitconfig ~/www/wwwroot/Git/user/.gitconfig

cp -i ~/www/nvm/default-packages ~/www/wwwroot/Git/user/nvm/default-packages
cp -i ~/.npmrc ~/www/wwwroot/Git/user/.npmrc

cp -i ~/www/JetBrains/*.app.vmoptions ~/www/wwwroot/Git/user/JetBrains

code .
