alias ssh='ssh -2 -4'

export SSHHosts=( $( grep ^Host ~/.ssh/hosts.ssh | awk '{print $2}' | tr '\n' ' ') )

complete -W "$SSHHosts" ssh
