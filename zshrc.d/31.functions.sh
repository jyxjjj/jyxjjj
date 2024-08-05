function writedefaults() {
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -boolean TRUE
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE
    defaults write com.apple.finder AppleShowAllFiles -boolean TRUE
    defaults write com.apple.finder ShowPathbar -bool TRUE
    defaults write com.apple.finder ShowStatusBar -bool TRUE
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE
}

function title() {
    echo "\033]0;${1}\007\c"
}

function path() {
    echo '\033[32mContent of /etc/paths:\033[0m'
    cat /etc/paths
    echo '\033[32mFiles of /etc/paths.d/:\033[0m'
    ls /etc/paths.d/
    echo '\033[32mContents of /etc/paths.d/*:\033[0m'
    cat /etc/paths.d/*
    echo '\033[32mContents of $PATH:\033[0m'
    local array=(${PATH//:/'\n'})
    for var in ${array[@]}
    do
        echo $var
    done
}

function tbw() {
    local str=$(smartctl -A disk0|grep 'Data Units Written')
    echo $str
}

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

function rmDSStore () {
    sudo find . -name '.DS_Store' -delete 2>/dev/null
    sudo find . -name '._.DS_Store' -delete 2>/dev/null
}

function filehash () {
    sha1 $1
    sha256 $1
    sha512 $1
}

function flushdns () {
    sudo killall -INFO mDNSResponder
    sudo killall -HUP mDNSResponder
    sudo killall -INFO mDNSResponder
    sudo killall -HUP mDNSResponder
    sudo killall -INFO mDNSResponder
    sudo killall mDNSResponderHelper
    sudo dscacheutil -flushcache
}

function deletexattr () {
    xattr -d com.apple.quarantine $1
    xattr -d com.apple.macl $1
    xattr -d com.apple.provenance $1
}
