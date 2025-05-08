alias artisan="php artisan"

function _artisan_get_command_list() {
    if [ -f artisan ]; then
        compadd $(php artisan --raw --no-ansi list | sed "s/[[:space:]].*//g")
    fi
}

compdef _artisan_get_command_list artisan
