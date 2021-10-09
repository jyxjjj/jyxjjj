cd() {
    builtin cd $1
    ls -alh
    case $PWD in
        (*/KJ/mp*)
            setphp 7.3
            ;;
    esac
}
