# Rsync-on-change watchers: rsw starts one in the background, lsw lists, dsw stops
function rsw --description 'Start rsync-on-change watcher'
    if test (count $argv) -ne 2
        echo "Usage: rsw <source> <destination>"
        return 1
    end

    set -l src (string replace -r '/$' '' -- $argv[1])
    set -l dest $argv[2]

    # Reuse one SSH connection per login, so 1Password only prompts once.
    set -l sockets $HOME/.ssh/sockets
    if set -q XDG_RUNTIME_DIR; and test -n "$XDG_RUNTIME_DIR"
        set sockets $XDG_RUNTIME_DIR
    end
    mkdir -p $sockets

    set -l rsh "ssh -o ControlMaster=auto -o ControlPath=$sockets/rsw-%r@%h:%p -o ControlPersist=yes"
    setsid --fork env RSYNC_RSH="$rsh" bash -c 'rsync -a "$1/" "$2"; while inotifywait -r -q -e modify,create,delete,move "$1"; do rsync -a "$1/" "$2"; done' rsw-watch $src $dest >/dev/null 2>&1
    echo "Watching $src -> $dest"
end
