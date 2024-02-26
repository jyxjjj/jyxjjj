#!/bin/zsh

cp ~/.zshrc ~/www/wwwroot/Git/user/.zshrc
cp -r ~/zshrc.d/* ~/www/wwwroot/Git/user/zshrc.d

cp ~/.gnupg/gpg-agent.conf ~/www/wwwroot/Git/user/.gnupg/gpg-agent.conf
cp ~/.gnupg/gpg.conf ~/www/wwwroot/Git/user/.gnupg/gpg.conf
cp ~/.gnupg/dirmngr.conf ~/www/wwwroot/Git/user/.gnupg/dirmngr.conf

cp ~/.ssh/config ~/www/wwwroot/Git/user/.ssh/config

cp ~/.gitconfig ~/www/wwwroot/Git/user/.gitconfig

cp ~/.npmrc ~/www/wwwroot/Git/user/.npmrc

cp ~/www/nvm/default-packages ~/www/wwwroot/Git/user/nvm/default-packages

cp ~/www/JetBrains/PhpStorm.app.vmoptions ~/www/wwwroot/Git/user/PhpStorm.app.vmoptions
cp ~/www/JetBrains/PyCharm.app.vmoptions ~/www/wwwroot/Git/user/PyCharm.app.vmoptions
cp ~/www/JetBrains/GoLand.app.vmoptions ~/www/wwwroot/Git/user/GoLand.app.vmoptions
cp ~/www/JetBrains/RubyMine.app.vmoptions ~/www/wwwroot/Git/user/RubyMine.app.vmoptions

code .
