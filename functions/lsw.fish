function lsw --description 'List rsync-on-change watchers'
    set -l found 0
    for line in (pgrep -af 'rsw-watch ')
        set -l pid (string split -m 1 ' ' -- $line)[1]
        set -l rest (string replace -r '^.*rsw-watch ' '' -- $line)
        set -l src (string replace -r ' [^ ]*$' '' -- $rest)
        set -l dest (string replace -r '^.* ' '' -- $rest)
        echo "$pid: $src -> $dest"
        set found 1
    end
    if test $found -eq 0
        echo "No active watches"
    end
end
