export PATH="/opt/homebrew/opt/php@8.4/bin:$PATH"

function setphp() {
    local newversion=$1
    if [[ ! "$newversion" =~ ^[0-9]\\.[0-9]$ ]]; then
        echo "Invalid PHP version format: $newversion."
        return 1
    fi
    local oldpaths="$PATH"
    local oldversion=$(echo "$PATH" | grep -oE 'php@[0-9]\.[0-9]' | awk -F'@' '{print $2}')
    if [ "$oldversion" = "$newversion" ]; then
        echo "PHP Version is already: $newversion"
        return
    fi
    echo "Switching PHP from $oldversion to $newversion..."
    export PATH=$(echo "$PATH" | sed -E "s|/opt/homebrew/opt/php@[0-9]\.[0-9]/bin:||")
    export PATH="/opt/homebrew/opt/php@$newversion/bin:$PATH"
    local versionstr=$(php -v | head -n 1 | grep -oE 'PHP [0-9]\.[0-9]' | awk '{print $2}')
    if [ "$versionstr" != "$newversion" ]; then
        echo "No such version $newversion"
        echo "Restoring original PHP version..."
        export PATH="$oldpaths"
        echo "PHP Version restored to: $oldversion"
    else
        echo "PHP switched from $oldversion to $newversion"
    fi
}

function getphp() {
    if [ -f composer.json ]; then
        local phpversion=$(jq -r '.require["php"]' composer.json | grep -oE '[0-9]\.[0-9]')
        if [ -n "$phpversion" ]; then
            echo "PHP version in composer.json: $phpversion"
            setphp $phpversion
            return
        fi
    fi
}

alias listphp='brew list -1 --full|grep shivammathur'

function installphpext() {
    brew install shivammathur/extensions/event@$1 shivammathur/extensions/igbinary@$1 shivammathur/extensions/msgpack@$1 shivammathur/extensions/redis@$1
}

function uninstallphpext() {
    brew uninstall shivammathur/extensions/event@$1 shivammathur/extensions/igbinary@$1 shivammathur/extensions/msgpack@$1 shivammathur/extensions/redis@$1
}
