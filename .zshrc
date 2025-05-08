autoload -U colors && colors

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

setopt histignoredups
setopt histignorealldups
setopt appendhistory
setopt sharehistory
setopt promptsubst

export LESSHISTFILE=/dev/null
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

PROMPT=$'
%{%F{cyan}%}================================%{%f%}
[%D{%H:%M:%S}] [%{%F{yellow}%}%?%{%f%}]
[%{%F{cyan}%}%n@%m%{%f%}]
[%{%F{green}%}%~%{%f%}]'

for f in ~/zshrc.d/*.sh; do
   source $f
done

export PROMPT

# Load Angular CLI autocompletion.
command -v ng > /dev/null && source <(ng completion script)
