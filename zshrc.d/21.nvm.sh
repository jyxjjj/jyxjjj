export NVM_DIR="$HOME/www/nvm"
[ -s "$HOME/www/nvm/nvm.sh" ] && \. "$HOME/www/nvm/nvm.sh"
[ -s "$HOME/www/nvm/bash_completion" ] && \. "$HOME/www/nvm/bash_completion"

function nvmupdate() {
    local old=$1
    local new=$2
    if [ -z "$old" ]; then
        old=$(nvm current | sed 's/v//')
    fi
    if [ -z "$new" ]; then
        new=$(nvm ls-remote | tail -n 1 | sed 's/ //g' | sed 's/v//' | sed 's/->//' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
    fi
    if [[ "$old" == "$new" ]]; then
        echo "No new version available."
        #return
    fi
    echo "Old: $old"
    echo "New: $new"
    echo "Update available: $old -> $new"
    echo "Do you want to proceed? (Y/n)\c"
    read -q -k 1 response
    echo -n "\n"
    if [[ $response == "N" || $response == "n" ]]; then
        echo "Aborting."
        return
    fi
    echo "Updating..."
    nvm install $new
    nvm uninstall $old
    nvm use $new
    nvm alias default $new
    npm i -g -U npm
    npm ls -g
    node -v
    npm -v
    echo "nvm install $new \
&& nvm uninstall $old \
&& nvm use $new \
&& nvm alias default $new \
&& npm i -g -U npm \
&& npm ls -g \
&& node -v \
&& npm -v"
}
