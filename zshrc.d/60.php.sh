export PATH="/opt/homebrew/opt/php@8.3/sbin:/opt/homebrew/opt/php@8.3/bin:$PATH"

function setphp(){
    local oldpaths=$PATH

    local old=$PATH[(i)php@]
    local version=$PATH[$(($old+4)),$(($old+6))]

    #echo Old version localed at: $old
    echo Old version is: $version
    
    if (($#1 != 3)) {
        echo -e '\033[31mVER LEN ERR\033[0m'
        return
    }
    echo New version is: $1

    export PATH=${PATH//php@"$version"/php@"$1"}

    echo Replaced \'$PATH[1,60]\' to \$PATH

    echo PHP is at: $(which php)
    local versionstr=$(php -v)
    local newversion=$versionstr[5,7]
    echo PHP version is: $newversion
    if [[ "$newversion" != "$1" ]] {
        echo -e '\033[31mVER MISMATCH\033[0m'
        echo 'Restored Change'
        export PATH=$oldpaths
        echo PHP is at: $(which php)
        local restoredversionstr=$(php -v)
        local restorednewversion=$restoredversionstr[5,7]
        echo PHP version is: $restorednewversion
    }
}
