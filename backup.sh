#!/bin/zsh

cp  ~/.zshrc ~/www/UserConfigs/.zshrc
rsync -rltDhzUc --info=progress2 --delete ~/zshrc.d/* ~/www/UserConfigs/zshrc.d

cp  ~/.gnupg/gpg-agent.conf ~/www/UserConfigs/.gnupg/gpg-agent.conf
cp  ~/.gnupg/gpg.conf ~/www/UserConfigs/.gnupg/gpg.conf
cp  ~/.gnupg/dirmngr.conf ~/www/UserConfigs/.gnupg/dirmngr.conf

cp  ~/.ssh/config ~/www/UserConfigs/.ssh/config

cp  ~/.gitconfig ~/www/UserConfigs/.gitconfig

cp  ~/www/nvm/default-packages ~/www/UserConfigs/nvm/default-packages

cp  ~/.npmrc ~/www/UserConfigs/.npmrc

cp  ~/www/JetBrains/*.app.vmoptions ~/www/UserConfigs/JetBrains

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    code ~/www/UserConfigs/
fi
