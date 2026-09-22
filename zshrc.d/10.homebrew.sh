#export HOMEBREW_BREW_GIT_REMOTE='https://mirrors.aliyun.com/homebrew/brew.git'
#export HOMEBREW_CORE_GIT_REMOTE='https://mirrors.aliyun.com/homebrew/homebrew-core.git'
#export HOMEBREW_BOTTLE_DOMAIN='https://mirrors.aliyun.com/homebrew/homebrew-bottles'
export HOMEBREW_EDITOR='code'
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_DOWNLOAD_CONCURRENCY=8
eval "$(/opt/homebrew/bin/brew shellenv)"

function removeMAU() {
    sudo -v
    sudo rm -rf "/Library/Application Support/Microsoft/MAU2.0"
    sudo rm -rf "/Library/Preferences/com.microsoft.autoupdate2.plist"
    sudo rm -rf "/Library/LaunchAgents/com.microsoft.update.agent.plist"
    sudo rm -rf "/Library/LaunchDaemons/com.microsoft.autoupdate.helper.plist"
    sudo rm -rf "/Library/PrivilegedHelperTools/com.microsoft.autoupdate.helper"
}
