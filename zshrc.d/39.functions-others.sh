function DeviceAge() {
    local BIRTH_TS=1642576960
    local NOW_TS=$(date +%s)
    local BIRTH=$(date -j -f "%s" "$BIRTH_TS" "+%Y-%m-%d %H:%M:%S")

    local DIFF=$((NOW_TS - BIRTH_TS))
    local DIFF_DATE=$(date -u -r "$DIFF" "+%Y %m %d %H %M %S")

    local D_YEAR=$(echo "$DIFF_DATE" | awk '{print $1 - 1970}')
    local D_MON=$(echo "$DIFF_DATE" | awk '{print $2 - 1}')
    local D_DAY=$(echo "$DIFF_DATE" | awk '{print $3 - 1}')
    local D_H=$(echo "$DIFF_DATE" | awk '{print $4 - 0}')
    local D_M=$(echo "$DIFF_DATE" | awk '{print $5 - 0}')
    local D_S=$(echo "$DIFF_DATE" | awk '{print $6 - 0}')

    echo "Activated Since: $BIRTH"
    echo "Device Age: ${D_YEAR}y ${D_MON}m ${D_DAY}d ${D_H}h ${D_M}m ${D_S}s"
}

function fns() {
    cat ~/zshrc.d/*.sh | grep 'func' | grep 'tion ' | grep -v fns | awk '{print $2}' | sed 's/()//' | sort
}
