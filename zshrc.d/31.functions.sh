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
    local str=$((smartctl -A disk0)|(grep 'Data Units Written'))
    echo $str
}

function listip() {
    echo "Internet4:                                  $(curl -s https://api.ipify.org)"
    echo "Internet6:                                  $(curl -s https://api6.ipify.org)"
    echo "en0(Wi-Fi)            (f4:d4:88:6e:06:b1):  $(ipconfig getifaddr en0)"
    echo "en1(Thunderbolt 1)    (36:85:02:21:fc:00):  $(ipconfig getifaddr en1)"
    echo "en2(Thunderbolt 2)    (36:85:02:21:fc:04):  $(ipconfig getifaddr en2)"
    echo "en3(Thunderbolt 3)    (36:85:02:21:fc:08):  $(ipconfig getifaddr en3)"
    echo "en4(Ethernet Adaptor) (ae:9c:e1:cb:6e:79):  $(ipconfig getifaddr en4)"
    echo "en5(Ethernet Adaptor) (ae:9c:e1:cb:6e:7a):  $(ipconfig getifaddr en5)"
    echo "en6(Ethernet Adapter) (ae:9c:e1:cb:6e:7b):  $(ipconfig getifaddr en6)"
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
