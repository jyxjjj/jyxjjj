#!/bin/zsh

cp  ~/.zshrc ~/www/wwwroot/Git/user/.zshrc
cp  ~/zshrc.d/* ~/www/wwwroot/Git/user/zshrc.d

cp  ~/.gnupg/gpg-agent.conf ~/www/wwwroot/Git/user/.gnupg/gpg-agent.conf
cp  ~/.gnupg/gpg.conf ~/www/wwwroot/Git/user/.gnupg/gpg.conf
cp  ~/.gnupg/dirmngr.conf ~/www/wwwroot/Git/user/.gnupg/dirmngr.conf

cp  ~/.ssh/config ~/www/wwwroot/Git/user/.ssh/config

cp  ~/.gitconfig ~/www/wwwroot/Git/user/.gitconfig

cp  ~/www/nvm/default-packages ~/www/wwwroot/Git/user/nvm/default-packages
cp  ~/.npmrc ~/www/wwwroot/Git/user/.npmrc

cp  ~/www/JetBrains/*.app.vmoptions ~/www/wwwroot/Git/user/JetBrains

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    code ~/www/wwwroot/Git/user/
fi
