function title() {
    echo "\033]0;${1}\007\c"
}

function path() {
    echo '\033[32mContent of /etc/paths:\033[0m'
    cat /etc/paths
    echo '\033[32mFiles of /etc/paths.d/:\033[0m'
    ls /etc/paths.d/
    echo '\033[32mContents of /etc/paths.d/*:\033[0m'
    cat /etc/paths.d/*
    echo '\033[32mContents of $PATH:\033[0m'
    local array=(${PATH//:/'\n'})
    for var in ${array[@]}; do
        echo $var
    done
}

function filehash() {
    sha1 $1
    sha256 $1
    sha512 $1
}

function filesize() {
    local size=$(curl -sIL --max-redirs 3 "$1" | grep -i 'Content-Length' | tail -n 1 | awk '{gsub("\r", ""); print $2}')
    if [[ -z "$size" || ! "$size" =~ ^[0-9]+$ ]]; then
        echo "Content-Length not found or invalid"
    else
        if ((size < 1024)); then
            echo "${size}B"
        elif ((size < 1024 * 1024)); then
            echo "$(awk -v size="$size" 'BEGIN {print size/1024"KB"}')"
        elif ((size < 1024 * 1024 * 1024)); then
            echo "$(awk -v size="$size" 'BEGIN {print size/1024/1024"MB"}')"
        else
            echo "$(awk -v size="$size" 'BEGIN {print size/1024/1024/1024"GB"}')"
        fi
    fi
}
