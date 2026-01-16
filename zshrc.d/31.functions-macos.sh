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

function windowsize() {
    osascript <<EOF
    tell application "System Events"
        if exists process "Telegram" then
            tell process "Telegram"
                repeat with w in windows
                    set size of w to {1024, 720}
                    delay 0.05
                    set position of w to {768, 360}
                end repeat
            end tell
        end if
        if exists process "QQ" then
            tell process "QQ"
                repeat with w in windows
                    set size of w to {1024, 720}
                    delay 0.05
                    set position of w to {768, 360}
                end repeat
            end tell
        end if
        if exists process "WeChat" then
            tell process "WeChat"
                repeat with w in windows
                    set size of w to {1024, 720}
                    delay 0.05
                    set position of w to {768, 360}
                end repeat
            end tell
        end if
        if exists process "DingTalk" then
            tell process "DingTalk"
                repeat with w in windows
                    set size of w to {1400, 850}
                    delay 0.05
                    set position of w to {580, 295}
                end repeat
            end tell
        end if
        if exists process "Feishu" then
            tell process "Feishu"
                repeat with w in windows
                    set size of w to {1400, 850}
                    delay 0.05
                    set position of w to {580, 295}
                end repeat
            end tell
        end if
        if exists process "PhpStorm" then
            tell process "PhpStorm"
                repeat with w in windows
                    set size of w to {2560, 1350}
                    delay 0.05
                    set position of w to {0, 0}
                end repeat
            end tell
        end if
        if exists process "Google Chrome" then
            tell process "Google Chrome"
                repeat with w in windows
                    set size of w to {1720, 1080}
                    delay 0.05
                    set position of w to {680, 220}
                end repeat
            end tell
        end if
        if exists process "Code" then
            tell process "Code"
                repeat with w in windows
                    set size of w to {1720, 1080}
                    delay 0.05
                    set position of w to {680, 220}
                end repeat
            end tell
        end if
    end tell
EOF
}

function lslaunch() {
    echo "\n📂 /Library/LaunchDaemons"
    ls -al /Library/LaunchDaemons

    echo "\n📂 /Library/LaunchAgents"
    ls -al /Library/LaunchAgents

    echo "\n📂 ~/Library/LaunchAgents"
    ls -al ~/Library/LaunchAgents
}

function clearIconCache() {
    sudo -v
    sudo rm -rf /Library/Caches/com.apple.iconservices.store
    sudo find /private/var/folders -name 'com.apple.iconservices.store' -delete
    sudo find /private/var/folders -name 'com.apple.iconservices' -delete
    qlmanage -r
    qlmanage -r cache
    killall Dock
    killall Finder
    killall SystemUIServer
}
