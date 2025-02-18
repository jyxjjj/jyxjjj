function gitlines() {
    local author=$1
    if [[ -z "$author" ]]; then
        author='jyxjjj'
    fi
    local date=$(date '+%Y-%m-%d 00:00:00')
    local hashregex='[a-z0-9]{40}|[a-z0-9]{64}'
    local awkstr=''
    echo Since $(git log --reverse --format="%cd" --date="format:%Y-%m-%d %H:%M:%S" | head -n 1)
    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; count+=$1; count+=$2; } END { print "Repo: Added: " add " Removed: " del " Total: " total " Count: " count }'
    git log --author=$author --numstat --pretty='%H' | grep -vE $hashregex | awk $awkstr
    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; count+=$1; count+=$2; } END { print "Today: Added: " add " Removed: " del " Total: " total " Count: " count }'
    git log --author=$author --numstat --pretty='%H' --since $date | grep -vE $hashregex | awk $awkstr
}
