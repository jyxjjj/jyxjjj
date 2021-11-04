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
    echo "Internet:                                   $(curl -s https://api.ipify.org)"
    echo "Internet:                                   $(curl -s https://api6.ipify.org)"
    echo "en0(Ethernet)         (14:98:77:47:c5:07):  $(ipconfig getifaddr en0)"
    echo "en1(Wi-Fi)            (14:98:77:5f:86:4f):  $(ipconfig getifaddr en1)"
    echo "en2(Thunderbolt 1)    (36:cf:8b:2d:89:84):  $(ipconfig getifaddr en2)"
    echo "en3(Thunderbolt 2)    (36:cf:8b:2d:89:80):  $(ipconfig getifaddr en3)"
    echo "en4(Ethernet Adaptor) (1e:00:33:3c:c8:54):  $(ipconfig getifaddr en4)"
    echo "en5(Ethernet Adaptor) (1e:00:33:3c:c8:55):  $(ipconfig getifaddr en5)"
    echo "en6(Bluetooth PAN)    (14:98:77:4a:59:9a):  $(ipconfig getifaddr en6)"
}
