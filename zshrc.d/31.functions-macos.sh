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

function removeMAU() {
    sudo -v
    sudo rm -rf "/Library/Application Support/Microsoft/MAU2.0"
    sudo rm -rf "/Library/LaunchAgents/com.microsoft.update.agent.plist"
    sudo rm -rf "/Library/LaunchDaemons/com.microsoft.autoupdate.helper.plist"
    sudo rm -rf "/Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper"
}

function lslaunch() {
    echo "\n📂 /Library/LaunchDaemons"
    ls -al /Library/LaunchDaemons

    echo "\n📂 /Library/LaunchAgents"
    ls -al /Library/LaunchAgents

    echo "\n📂 ~/Library/LaunchAgents"
    ls -al ~/Library/LaunchAgents
}
