function flushdns() {
    sudo -v
    sudo killall -INFO mDNSResponder
    sudo killall -HUP mDNSResponder
    sudo killall -INFO mDNSResponder
    sudo killall -HUP mDNSResponder
    sudo killall -INFO mDNSResponder
    sudo killall mDNSResponderHelper
    sudo dscacheutil -flushcache
}

function ZTstatus() {
    echo "================================================================"
    zerotier-cli status
    echo "================================================================"
    zerotier-cli listnetworks
    echo "================================================================"
    zerotier-cli peers
    echo "================================================================"
    zerotier-cli listpeers
    echo "================================================================"
}

function ZTrestart() {
    sudo -v
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
    sleep 10
    ZTstatus
}

function ZTstop() {
    sudo -v
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
}

function ZTstart() {
    sudo -v
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
}
