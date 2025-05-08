function deletexattr() {
    xattr -d com.apple.quarantine $1
    xattr -d com.apple.macl $1
    xattr -d com.apple.provenance $1
}

function rmDSStore() {
    sudo -v
    sudo find . -type f -name '.DS_Store' -delete 2>/dev/null &
    sudo find . -type f -name '._.DS_Store' -delete 2>/dev/null &
}

function writedefaults() {
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean TRUE &
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE &
    defaults write com.apple.finder AppleShowAllFiles -boolean TRUE &
    defaults write com.apple.finder ShowPathbar -bool TRUE &
    defaults write com.apple.finder ShowStatusBar -bool TRUE &
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE &
    defaults write com.apple.Dock autohide-delay -float 0 &
}
