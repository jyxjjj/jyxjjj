#!/bin/zsh -i -l

unalias cp

cp ~/.zshrc ~/www/UserConfigs/.zshrc
rsync --info=progress2 --delete ~/zshrc.d/ ~/www/UserConfigs/zshrc.d/

cp ~/.gnupg/gpg-agent.conf ~/www/UserConfigs/.gnupg/gpg-agent.conf
cp ~/.gnupg/gpg.conf ~/www/UserConfigs/.gnupg/gpg.conf
cp ~/.gnupg/dirmngr.conf ~/www/UserConfigs/.gnupg/dirmngr.conf

cp ~/.ssh/config ~/www/UserConfigs/.ssh/config

cp ~/.gitconfig ~/www/UserConfigs/.gitconfig

cp ~/www/nvm/default-packages ~/www/UserConfigs/nvm/default-packages

cp ~/.npmrc ~/www/UserConfigs/.npmrc

cp ~/www/JetBrains/*.app.vmoptions ~/www/UserConfigs/JetBrains

defaults delete com.apple.terminal NSOSPLastRootDirectory
plutil -convert xml1 ~/Library/Preferences/com.apple.Terminal.plist -o ~/Library/Preferences/com.apple.Terminal.plist
cp ~/Library/Preferences/com.apple.Terminal.plist ~/www/UserConfigs/com.apple.Terminal.plist

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    code ~/www/UserConfigs/
fi

git a

githubdesktop .
