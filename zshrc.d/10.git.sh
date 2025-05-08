GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"
GIT_PS1_DESCRIBE_STYLE="default"
source ~/zshrc.d/.git-prompt.sh

PROMPT+=$'$(__git_ps1)$ '

function githubdesktop() {
    if [ -z "$1" ]; then
        echo "Usage: githubdesktop <path>"
        return
    fi
    BAT="/Applications/GitHub Desktop.app/Contents/Resources/app/static/github.sh"
    BIN="/Applications/GitHub Desktop.app/Contents/MacOS/GitHub Desktop"
    CLI="/Applications/GitHub Desktop.app/Contents/Resources/app/cli.js"
    if [ -f "$BIN" ] && [ -f "$CLI" ]; then
        ELECTRON_RUN_AS_NODE=1 "$BIN" "$CLI" "open" "$@"
    elif [ -f "$BAT" ]; then
        "$BAT" "open" "$@"
    else
        echo "GitHub Desktop not found"
    fi
}
