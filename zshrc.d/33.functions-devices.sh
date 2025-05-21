function listip() {
    echo "Inet4:                                      $(curl -s https://api.ipify.org)"
    echo "Inet6:                                      $(curl -s https://api6.ipify.org)"
    echo "Internet:                                   $(curl -s https://www.desmg.com/api/IP)"
    echo "en0(Wi-Fi)            ($(ifconfig en0 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en0)"
    echo "en1(Thunderbolt 1)    ($(ifconfig en1 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en1)"
    echo "en2(Thunderbolt 2)    ($(ifconfig en2 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en2)"
    echo "en3(Thunderbolt 3)    ($(ifconfig en3 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en3)"
    echo "en4(Ethernet Adaptor) ($(ifconfig en4 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en4)"
    echo "en5(Ethernet Adaptor) ($(ifconfig en5 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en5)"
    echo "en6(Ethernet Adapter) ($(ifconfig en6 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en6)"
}

if [[ ! -d "/Volumes/TMP" ]]; then
    LOCKDIR="$TMPDIR/TMPVolumeCreator.lock"
    if mkdir "$LOCKDIR" 2>/dev/null; then
        diskutil erasevolume 'Case-sensitive APFS' 'TMP' "$(hdiutil attach -nomount ram://2097152)" >/dev/null 2>&1
        rm -rf "$LOCKDIR"
    fi
fi
