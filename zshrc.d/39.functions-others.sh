function gitlines() {
    local author=$1
    if [[ -z "$author" ]]; then
        author='jyxjjj'
    fi
    local date=$(date '+%Y-%m-%d 00:00:00')
    local hashregex='[a-z0-9]{40}|[a-z0-9]{64}'
    local awkstr=''
    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; } END { print "Repo: Added: " add " Removed: " del " Total: " total }'
    git log --author=$author --numstat --pretty='%H' | grep -vE $hashregex | awk $awkstr
    awkstr='{ add+=$1; del+=$2; total+=$1; total-=$2; } END { print "Today: Added: " add " Removed: " del " Total: " total }'
    git log --author=$author --numstat --pretty='%H' --since $date | grep -vE $hashregex | awk $awkstr
}
