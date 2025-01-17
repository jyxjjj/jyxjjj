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

source ~/zshrc.d/01.proxy.sh
source ~/zshrc.d/02.ssh.sh

source ~/zshrc.d/10.git.sh

source ~/zshrc.d/20.homebrew.sh

source ~/zshrc.d/30.alias.sh
source ~/zshrc.d/31.functions.sh

source ~/zshrc.d/40.chrome.sh

source ~/zshrc.d/50.gpg.sh

source ~/zshrc.d/59.android.sh

source ~/zshrc.d/60.php.sh
source ~/zshrc.d/61.artisan.sh
source ~/zshrc.d/62.nvm.sh
source ~/zshrc.d/63.ruby.sh

source ~/zshrc.d/99.chpwd.sh

export PROMPT

# Load Angular CLI autocompletion.
command -v ng > /dev/null && source <(ng completion script)
