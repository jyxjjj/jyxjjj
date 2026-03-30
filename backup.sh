#!/bin/zsh -i -l

set -e

unalias rsync
alias rsync='rsync -cDhlrtUz'

BASE_DIR=$HOME/www/UserConfigs

defaults delete com.apple.terminal NSOSPLastRootDirectory 2>/dev/null || true
defaults delete com.apple.terminal LastTerminalStartTime 2>/dev/null || true
defaults delete com.apple.terminal TTSettingsSnapshotSent 2>/dev/null || true
plutil -convert xml1 $HOME/Library/Preferences/com.apple.Terminal.plist -o $HOME/Library/Preferences/com.apple.Terminal.plist

rsync $HOME/.zshrc $BASE_DIR/.zshrc
rsync --delete $HOME/zshrc.d/ $BASE_DIR/zshrc.d/

rsync $HOME/.gnupg/gpg-agent.conf $BASE_DIR/.gnupg/gpg-agent.conf
rsync $HOME/.gnupg/gpg.conf $BASE_DIR/.gnupg/gpg.conf
rsync $HOME/.gnupg/dirmngr.conf $BASE_DIR/.gnupg/dirmngr.conf

rsync $HOME/.ssh/config $BASE_DIR/.ssh/config

rsync $HOME/.gitconfig $BASE_DIR/.gitconfig

rsync $HOME/www/nvm/default-packages $BASE_DIR/nvm/default-packages

rsync $HOME/.npmrc $BASE_DIR/.npmrc

rsync $HOME/www/JetBrains/*.app.vmoptions $BASE_DIR/JetBrains

rsync $HOME/Library/Preferences/com.apple.Terminal.plist $BASE_DIR/HKCU/Library/Preferences/com.apple.Terminal.plist

rsync /Library/LaunchDaemons/com.desmg.zshrc_Apple_Terminal_Remover.plist $BASE_DIR/HKLM/Library/LaunchDaemons/com.desmg.zshrc_Apple_Terminal_Remover.plist

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    code $BASE_DIR/
fi

git a

githubdesktop .
