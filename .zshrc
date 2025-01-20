autoload -U colors && colors

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

setopt histignoredups
setopt histignorealldups
setopt appendhistory
setopt sharehistory
setopt promptsubst

export LESSHISTFILE=/dev/null

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
