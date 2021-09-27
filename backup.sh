#!/bin/zsh

cp ~/.zshrc ~/www/wwwroot/Git/user/.zshrc
cp -r ~/zshrc.d/* ~/www/wwwroot/Git/user/zshrc.d

cp ~/.ssh/config ~/www/wwwroot/Git/user/.ssh/config

cp ~/.gnupg/gpg-agent.conf ~/www/wwwroot/Git/user/.gnupg/gpg-agent.conf
cp ~/.gnupg/gpg.conf ~/www/wwwroot/Git/user/.gnupg/gpg.conf
cp ~/.gnupg/dirmngr.conf ~/www/wwwroot/Git/user/.gnupg/dirmngr.conf
cp ~/.gnupg/sshcontrol ~/www/wwwroot/Git/user/.gnupg/sshcontrol

cp ~/.gitconfig ~/www/wwwroot/Git/user/.gitconfig

cp ~/.npmrc ~/www/wwwroot/Git/user/.npmrc

cp ~/www/JetBrains/PhpStorm.app.vmoptions ~/www/wwwroot/Git/user/PhpStorm.app.vmoptions
