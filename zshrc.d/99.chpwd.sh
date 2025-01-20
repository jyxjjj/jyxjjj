function cd() {
    builtin cd $1
    ls -alh
    getphp
}

getphp
