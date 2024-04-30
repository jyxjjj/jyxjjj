#!/bin/zsh
export SSHHosts=( $( grep ^Host ~/.ssh/hosts.ssh | awk '{print $2}' | tr '\n' ' ') )

complete -W "$SSHHosts" ssh
