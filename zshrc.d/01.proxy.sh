function setproxy(){
    export http_proxy='socks5h://127.0.0.1:7890'
    export https_proxy='socks5h://127.0.0.1:7890'
    export socks5_proxy='socks5h://127.0.0.1:7890'
    export all_proxy='socks5h://127.0.0.1:7890'
}

function unsetproxy(){
    export http_proxy=''
    export https_proxy=''
    export socks5_proxy=''
    export all_proxy=''
}
