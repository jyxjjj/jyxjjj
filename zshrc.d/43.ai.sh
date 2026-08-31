export LLAMA_ARG_UBATCH=1
export LLAMA_ARG_MLOCK=1
export LLAMA_ARG_MMAP=1
export LLAMA_ARG_CACHE_TYPE_K=f16
export LLAMA_ARG_CACHE_TYPE_V=f16
export LLAMA_MODELS_MAX=1
export LLAMA_ARG_N_PARALLEL=1
export LLAMA_ARG_CTX_SIZE=16384
export LLAMA_ARG_HOST=127.0.0.1
export LLAMA_ARG_PORT=11434
alias llama-cli='llama-cli --temp 0.1'
alias llama-server='llama-server --temp 0.1'

mkdir -p \
    /Volumes/TMP/Codex/.tmp \
    /Volumes/TMP/Codex/tmp \
    /Volumes/TMP/Codex/TMPDIR \
    /Volumes/TMP/Codex/node_repl \
    /Volumes/TMP/Codex/shell_snapshots \
    /Volumes/TMP/Codex/attachments \
    /Volumes/TMP/Codex/generated_images \
    /Volumes/TMP/Codex/visualizations \
    /Volumes/TMP/Codex/browser \
    /Volumes/TMP/Codex/cache \
    /Volumes/TMP/Codex/dictation-history \
    '/Volumes/TMP/Codex/Library/Caches/Codex' \
    '/Volumes/TMP/Codex/Library/Application Support/Codex'

function lnCodex() {
    if ! isRAMDisk /Volumes/TMP; then
        echo "Error: /Volumes/TMP is not a RAM Disk." >&2
        return 1
    fi

    function _lnCodex() {
        local target="$1"
        local link="$2"

        if [[ -L "$link" ]]; then
            if [[ "$(readlink "$link")" != "$target" ]]; then
                echo "Warning: Symbolic link points to an unexpected target: $link -> $(readlink "$link")" >&2
                return 1
            fi

            return 0
        fi

        if [[ -e "$link" ]]; then
            echo "Warning: This file/directory already exists and is not a symbolic link: $link" >&2
            return 1
        fi

        ln -s "$target" "$link"
    }

    _lnCodex '/Volumes/TMP/Codex/Library/Application Support/Codex' "$HOME/Library/Application Support/Codex"
    _lnCodex '/Volumes/TMP/Codex/Library/Caches/Codex' "$HOME/Library/Caches/Codex"

    _lnCodex '/Volumes/TMP/Codex/.tmp' "$HOME/.codex/.tmp"
    _lnCodex '/Volumes/TMP/Codex/attachments' "$HOME/.codex/attachments"
    _lnCodex '/Volumes/TMP/Codex/browser' "$HOME/.codex/browser"
    _lnCodex '/Volumes/TMP/Codex/cache' "$HOME/.codex/cache"
    _lnCodex '/Volumes/TMP/Codex/dictation-history' "$HOME/.codex/dictation-history"
    _lnCodex '/Volumes/TMP/Codex/generated_images' "$HOME/.codex/generated_images"
    _lnCodex '/Volumes/TMP/Codex/node_repl' "$HOME/.codex/node_repl"
    _lnCodex '/Volumes/TMP/Codex/shell_snapshots' "$HOME/.codex/shell_snapshots"
    _lnCodex '/Volumes/TMP/Codex/tmp' "$HOME/.codex/tmp"

    _lnCodex '/Volumes/TMP/Codex/goals_1.sqlite' "$HOME/.codex/goals_1.sqlite"
    _lnCodex '/Volumes/TMP/Codex/goals_1.sqlite-shm' "$HOME/.codex/goals_1.sqlite-shm"
    _lnCodex '/Volumes/TMP/Codex/goals_1.sqlite-wal' "$HOME/.codex/goals_1.sqlite-wal"

    _lnCodex '/Volumes/TMP/Codex/logs_2.sqlite' "$HOME/.codex/logs_2.sqlite"
    _lnCodex '/Volumes/TMP/Codex/logs_2.sqlite-shm' "$HOME/.codex/logs_2.sqlite-shm"
    _lnCodex '/Volumes/TMP/Codex/logs_2.sqlite-wal' "$HOME/.codex/logs_2.sqlite-wal"

    _lnCodex '/Volumes/TMP/Codex/memories_1.sqlite' "$HOME/.codex/memories_1.sqlite"
    _lnCodex '/Volumes/TMP/Codex/memories_1.sqlite-shm' "$HOME/.codex/memories_1.sqlite-shm"
    _lnCodex '/Volumes/TMP/Codex/memories_1.sqlite-wal' "$HOME/.codex/memories_1.sqlite-wal"

    _lnCodex '/Volumes/TMP/Codex/queue_1.sqlite' "$HOME/.codex/queue_1.sqlite"
    _lnCodex '/Volumes/TMP/Codex/queue_1.sqlite-shm' "$HOME/.codex/queue_1.sqlite-shm"
    _lnCodex '/Volumes/TMP/Codex/queue_1.sqlite-wal' "$HOME/.codex/queue_1.sqlite-wal"

    _lnCodex '/Volumes/TMP/Codex/thread_history_1.sqlite' "$HOME/.codex/thread_history_1.sqlite"
    _lnCodex '/Volumes/TMP/Codex/thread_history_1.sqlite-shm' "$HOME/.codex/thread_history_1.sqlite-shm"
    _lnCodex '/Volumes/TMP/Codex/thread_history_1.sqlite-wal' "$HOME/.codex/thread_history_1.sqlite-wal"

    unfunction _lnCodex
}

function openCodex() {
    open -a "/Applications/ChatGPT.app" --env TMPDIR=/Volumes/TMP/Codex/TMPDIR
}
