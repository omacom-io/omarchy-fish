function tdl
    if test -z "$argv[1]"
        echo "Usage: tdl <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end

    if not tmux display-message -p -t $TMUX_PANE &>/dev/null
        echo "You must start tmux to use tdl."
        return 1
    end

    set -l current_dir (pwd)
    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l editor_pane $TMUX_PANE

    tmux rename-window -t $editor_pane (basename $current_dir)

    tmux split-window -v -p 15 -t $editor_pane -c $current_dir

    set -l ai_pane (tmux split-window -h -p 30 -t $editor_pane -c $current_dir -P -F '#{pane_id}')

    if test -n "$ai2"
        set -l ai2_pane (tmux split-window -v -t $ai_pane -c $current_dir -P -F '#{pane_id}')
        tmux send-keys -t $ai2_pane "$ai2" C-m
    end

    tmux send-keys -t $ai_pane "$ai" C-m

    set -q EDITOR && tmux send-keys -t $editor_pane "$EDITOR ." C-m

    tmux select-pane -t $editor_pane
end
