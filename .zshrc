autoload -U colors && colors

setopt histignoredups
setopt histignorealldups
setopt appendhistory
setopt sharehistory
setopt promptsubst

PROMPT=$'
%{%F{cyan}%}================================%{%f%}
[%*] [%{%F{yellow}%}%?%{%f%}]
[%{%F{cyan}%}%n@%m%{%f%}]
[%{%F{green}%}%~%{%f%}]'


source ~/zshrc.d/01.proxy.sh

source ~/zshrc.d/10.git.sh

source ~/zshrc.d/20.homebrew.sh
source ~/zshrc.d/21.nvm.sh

source ~/zshrc.d/30.alias.sh
source ~/zshrc.d/31.functions.sh

source ~/zshrc.d/50.gpg.sh

source ~/zshrc.d/60.php.sh

source ~/zshrc.d/99.chpwd.sh

export PROMPT

# Load Angular CLI autocompletion.
command -v ng && source <(ng completion script)
