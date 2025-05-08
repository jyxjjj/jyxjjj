function flushdns() {
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
    sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
    sleep 5
    ZTstatus
}
