export SETEDPHPFORKJ=0

function cd() {
    builtin cd $1
    ls -alh
    case $PWD in
        (*/KJ/applet*)
            if (( SETEDPHPFORKJ == 0 )) {
                export SETEDPHPFORKJ=1
            }
            ;;
        (*/KJ/nanjing*)
            if (( SETEDPHPFORKJ == 0 )) {
                export SETEDPHPFORKJ=1
            }
            ;;
        (*/KJ/monitor*)
            if (( SETEDPHPFORKJ == 0 )) {
                export SETEDPHPFORKJ=1
            }
            ;;
        (*/KJ/*)
            if (( SETEDPHPFORKJ == 0 )) {
                setphp 7.3
                export SETEDPHPFORKJ=1
            }
            ;;
    esac
}
