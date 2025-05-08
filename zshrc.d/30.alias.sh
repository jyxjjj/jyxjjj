alias ls='ls -a'
alias ll='ls -al'
alias lh='ls -alh'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

alias grep='grep --color=auto'

alias free='vm_stat'

alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffplay -hide_banner'
alias ffprobe='ffprobe -hide_banner'

alias sha1='openssl dgst -hex -sha1'
alias sha256='openssl dgst -hex -sha256'
alias sha512='openssl dgst -hex -sha512'

alias rsync='rsync -cDhlrtUz'

alias tbw='smartctl -A disk0 | grep "Data Units Written"'
