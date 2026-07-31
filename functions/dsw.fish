function dsw --description 'Stop rsync-on-change watchers'
    set -l found 0
    for pid in (pgrep -f 'rsw-watch ')
        if kill -- -$pid 2>/dev/null
            echo "Stopped watch (pid $pid)"
            set found 1
        end
    end
    if test $found -eq 0
        echo "No active watches"
    end
end
