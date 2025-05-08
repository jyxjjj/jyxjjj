alias Chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias google-chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias Google-Chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias Chromium='/Applications/Chromium.app/Contents/MacOS/Chromium'
alias chromium='/Applications/Chromium.app/Contents/MacOS/Chromium'

function newChrome() {
    local temp_dir=$(mktemp -d /tmp/ChromeProfile.XXXXXX)
    local chrome_args=""
    if [[ "$1" == "true" ]]; then
        chrome_args="$chrome_args --headless --disable-gpu"
    fi
    eval "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    --user-data-dir="$temp_dir" \
    --enable-features=ParallelDownloading \
    --allow-file-access-from-files \
    --disable-web-security \
    --no-default-browser-check \
    --disable-sync \
    --no-first-run \
    --disable-background-networking \
    --disable-default-apps \
    --disable-extensions \
    --disable-plugins \
    --disable-component-update \
    --disable-predicting-network-actions \
    --disable-backgrounding-occluded-windows \
    --disable-cache \
    --auto-open-devtools-for-tabs \
    $chrome_args"
    rm -rf "$temp_dir"
}
