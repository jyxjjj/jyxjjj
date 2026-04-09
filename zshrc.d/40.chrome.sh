alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias google-chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

function newChrome() {
    local temp_dir=$(mktemp -d /tmp/ChromeProfile.XXXXXX)
    local chrome_args=""
    if [[ "$1" == "1" ]]; then
        chrome_args="$chrome_args --headless --disable-gpu"
    fi
    if [[ "$2" == "1" ]]; then
        chrome_args="$chrome_args --allow-file-access-from-files --disable-web-security"
    fi
    if [[ "$3" == "1" ]]; then
        chrome_args="$chrome_args --remote-debugging-port=9222"
    fi
    eval "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    --window-size=1920,1080 \
    --user-data-dir="$temp_dir" \
    --enable-features=ParallelDownloading \
    --auto-open-devtools-for-tabs \
    --disable-background-timer-throttling \
    --disable-backgrounding-occluded-windows \
    --disable-breakpad \
    --disable-cache \
    --disable-client-side-phishing-detection \
    --disable-component-extensions-with-background-pages \
    --disable-component-update \
    --disable-crash-reporter \
    --disable-default-apps \
    --disable-extensions \
    --disable-features=LockProfileCookieDatabase,DialMediaRouteProvider,LensOverlay,MediaRouter,OptimizationHints \
    --disable-field-trial-config \
    --disable-hang-monitor \
    --disable-infobars \
    --disable-metrics \
    --disable-new-tab-first-run \
    --disable-plugins \
    --disable-predicting-network-actions \
    --disable-prompt-on-repost \
    --disable-renderer-backgrounding \
    --disable-save-password-bubble \
    --disable-search-engine-choice-screen \
    --disable-smooth-scrolling \
    --disable-sync \
    --disable-translate \
    --hide-crash-restore-bubble \
    --no-default-browser-check \
    --no-first-run \
    --no-service-autorun \
    --password-store=basic \
    --safebrowsing-disable-auto-update \
    --use-mock-keychain \
    $chrome_args"
    rm -rf "$temp_dir"
}
