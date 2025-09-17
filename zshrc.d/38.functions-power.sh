function setPM() {
    sudo -v
    sudo pmset -c \
        displaysleep 30 \
        disksleep 30 \
        sleep 0 \
        womp 1 \
        powernap 1 \
        autorestart 1 \
        lidwake 1 \
        acwake 1 \
        lessbright 0 \
        halfdim 0 \
        sms 1 \
        hibernatemode 0 \
        ttyskeepawake 1 \
        networkoversleep 1 \
        destroyfvkeyonstandby 0
    sudo pmset -b \
        displaysleep 15 \
        disksleep 10 \
        sleep 15 \
        womp 1 \
        powernap 1 \
        autorestart 1 \
        lidwake 1 \
        acwake 1 \
        lessbright 1 \
        halfdim 0 \
        sms 1 \
        hibernatemode 3 \
        ttyskeepawake 1 \
        networkoversleep 1 \
        destroyfvkeyonstandby 0
}
