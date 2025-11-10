# do not use autoload -U add-zsh-hook to make compatible with bash
function cd() {
    builtin cd "$@" || return
    ls -alh
}
