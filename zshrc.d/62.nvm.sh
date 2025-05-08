export NVM_DIR="$HOME/www/nvm"
[ -s "$HOME/www/nvm/nvm.sh" ] && \. "$HOME/www/nvm/nvm.sh"
[ -s "$HOME/www/nvm/bash_completion" ] && \. "$HOME/www/nvm/bash_completion"

function nvmupdate() {
    local old=$1
    local new=$2
    if [ -z "$old" ]; then
        old=$(nvm current | sed 's/v//' | tr -d '\n')
    fi
    if [ -z "$new" ]; then
        new=$(nvm ls-remote | grep LTS | tail -n 1 | awk '{print $1}' | sed 's/v//' | tr -d '\n')
    fi
    if [[ "$old" == "$new" ]]; then
        echo "No new version available."
        #return
    fi
    echo "Old: $old"
    echo "New: $new"
    echo "Update available: $old -> $new"
    echo "Do you want to proceed? (Y/n)\c"
    read -k 1 response
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
