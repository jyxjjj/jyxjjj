GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUNTRACKEDFILES="yes"
GIT_PS1_DESCRIBE_STYLE="default"
source ~/zshrc.d/.git-prompt.sh

PROMPT+=$'$(__git_ps1)$ '

function githubdesktop() {
    if [ -z "$1" ]; then
        echo "Usage: githubdesktop [args]"
        return 1
    fi
    BIN="/Applications/GitHub Desktop.app/Contents/MacOS/GitHub Desktop"
    CLI="/Applications/GitHub Desktop.app/Contents/Resources/app/cli.js"
    if [ -f "$BIN" ] && [ -f "$CLI" ]; then
        ELECTRON_RUN_AS_NODE=1 "$BIN" "$CLI" "$@"
    else
        echo "GitHub Desktop not found"
    fi
}

alias ghd="githubdesktop ."

function gitlines() {
    local author=$1
    local since=$2

    if [[ -z "$author" ]]; then
        author='jyxjjj'
    fi

    if [[ -z "$since" ]]; then
        since=$(date '+%Y-%m-%d 00:00:00')
    fi

    local hashregex='[a-z0-9]{40}|[a-z0-9]{64}'
    local awkstr=''

    echo "Created $(git log --reverse --format="%cd" --date="format:%Y-%m-%d %H:%M:%S" | head -n 1)"

    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; count+=$1; count+=$2; } END { print "Repo: Added: " add " Removed: " del " Total: " total " Count: " count }'
    git log --author=$author --numstat --pretty='%H' | grep -vE "$hashregex" | awk "$awkstr"

    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; count+=$1; count+=$2; } END { print "Since '$since': Added: " add " Removed: " del " Total: " total " Count: " count }'
    git log --author=$author --numstat --pretty='%H' --since "$since" | grep -vE "$hashregex" | awk "$awkstr"
}
