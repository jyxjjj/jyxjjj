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

function ZTrouteSet() {
    ZTrouteDel
    ip route add 10.0.254.0/24 via 192.168.50.3
}

function ZTrouteDel() {
    ip route delete 10.0.254.0/24 via 192.168.50.3 2>/dev/null || true
}

function ZTstatus() {
    function _zt_status() {
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
    watch -n 1 _zt_status
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
    if [[ $(ifconfig en0 | grep inet | awk '{print $2}') == "192.168.50.6" ]]; then
        ZTrouteSet
    fi
}

function ZTstart() {
    sudo -v
    ZTrouteDel
    sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
}
