function listip() {
    echo "Default Egress 4:      $(curl --max-time 2 -4 -s https://ifconfig.me)"
    echo "Default Egress 6:      $(curl --max-time 2 -6 -s https://ifconfig.me)"
    echo "Global Egress4:        $(curl --max-time 2 -4 -s https://www.desmg.com/api/IP)"
    echo "Global Egress6:        $(curl --max-time 2 -6 -s https://www.desmg.com/api/IP)"
    echo "en0(Wi-Fi)             ($(ifconfig en0 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en0)"
    echo "en1(Thunderbolt 1)     ($(ifconfig en1 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en1)"
    echo "en6(Thunderbolt 2)     ($(ifconfig en6 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en6)"
    echo "en2(Thunderbolt 3)     ($(ifconfig en2 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en2)"
    echo "en3(Ethernet Adapter)  ($(ifconfig en3 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en3)"
    echo "en4(Ethernet Adapter)  ($(ifconfig en4 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en4)"
    echo "en5(Ethernet Adapter)  ($(ifconfig en5 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en5)"
    echo "en7(Ethernet Adapter)  ($(ifconfig en7 | grep ether | awk '{print $2}')):  $(ipconfig getifaddr en7)"
}

function mountTMP() {
    if [[ ! -d "/Volumes/TMP" ]]; then
        LOCKFILE="$TMPDIR/TMPVolumeCreator.lock"
        if [[ -f "$LOCKFILE" ]]; then
            return 1
        fi
        touch "$LOCKFILE"
        RAMDISK=$(hdiutil attach -nomount ram://8388608 2>/dev/null | xargs)
        echo "Creating RAM disk at $RAMDISK..."
        if [[ ! -b "$RAMDISK" ]]; then
            echo "Error: Failed to create RAM disk $RAMDISK."
            diskutil eject "$RAMDISK" >/dev/null 2>&1 || true
            rm -f "$LOCKFILE"
            return 1
        fi
        diskutil erasevolume 'Case-sensitive APFS' 'TMP' "$RAMDISK" >/dev/null 2>&1 || { 
            echo "Error: Failed to format RAM disk $RAMDISK."
            diskutil eject "$RAMDISK" >/dev/null 2>&1 || true
            rm -f "$LOCKFILE"
            return 1
        }
        rm -rf "$LOCKFILE"
        echo "RAM disk mounted at /Volumes/TMP."
    fi
}

function unmountTMP() {
    if [[ -d "/Volumes/TMP" ]]; then
        diskutil eject "/Volumes/TMP" >/dev/null 2>&1 || true
    fi
}

mountTMP
