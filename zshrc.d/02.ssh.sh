alias ssh='ssh -2 -4'

rm -f "$HOME/.ssh/known_hosts"

export SSHHosts=($(grep ^Host ~/.ssh/hosts.ssh | awk '{print $2}' | tr '\n' ' '))

complete -W "$SSHHosts" ssh

function cleanSSH() {
    rm -f "$HOME/.ssh/control-"*
}
