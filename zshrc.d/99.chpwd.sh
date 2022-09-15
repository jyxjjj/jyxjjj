export SETEDPHPFORMP=0

function cd() {
    builtin cd $1
    ls -alh
    case $PWD in
        (*/KJ/*)
            if (( SETEDPHPFORKJ == 0 )) {
                setphp 7.3
                export SETEDPHPFORKJ=1
            }
            ;;
    esac
}
