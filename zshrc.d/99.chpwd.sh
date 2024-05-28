function cd() {
    builtin cd $1
    ls -alh
    if [ -f ".phpver" ]; then
        PHPVER=$(cat .phpver)
        if [ -n "$PHPVER" ]; then
            setphp $PHPVER
        fi
    fi
}
