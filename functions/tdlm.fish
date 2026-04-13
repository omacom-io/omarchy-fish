function tdlm
    if test -z "$argv[1]"
        echo "Usage: tdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end

    if not tmux display-message -p -t $TMUX_PANE &>/dev/null
        echo "You must start tmux to use tdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir (pwd)
    set -l first true

    set -l session_name (basename $base_dir | tr '.:' '--')
    tmux rename-session $session_name

    for dir in $base_dir/*/
        if test -d "$dir"
            set -l dirpath (string trim --right --chars=/ "$dir")

            if test "$first" = "true"
                tmux send-keys -t $TMUX_PANE "cd '$dirpath' && tdl $ai $ai2" C-m
                set -l first false
            else
                set -l pane_id (tmux new-window -c "$dirpath" -P -F '#{pane_id}')
                tmux send-keys -t $pane_id "tdl $ai $ai2" C-m
            end
        end
    end
end
