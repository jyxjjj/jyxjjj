export SETEDPHPFORMP=0

function cd() {
    builtin cd $1
    ls -alh
    case $PWD in
        (*/KJ/mp*)
            if (( SETEDPHPFORMP == 0 )) {
                setphp 7.3
                export SETEDPHPFORMP=1
            }
            ;;
    esac
}
