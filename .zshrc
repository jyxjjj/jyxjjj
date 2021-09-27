autoload -U colors && colors

setopt histignoredups
setopt appendhistory
setopt sharehistory
setopt promptsubst

PROMPT=$'\n%F{cyan}================================%f\n[%D{%Y-%m-%d %H:%M:%S}] [%F{yellow}%?%f]\n[%F{cyan}%n@%m%f]\n[%F{green}%~%f]'

source ~/zshrc.d/01.proxy.sh

source ~/zshrc.d/10.git.sh

source ~/zshrc.d/20.homebrew.sh
source ~/zshrc.d/21.nvm.sh

source ~/zshrc.d/30.alias.sh
source ~/zshrc.d/31.functions.sh

source ~/zshrc.d/50.gpg.sh

source ~/zshrc.d/99.php.sh

export PROMPT
