function tsl
    if test (count $argv) -lt 2
        echo "Usage: tsl <pane_count> <command>"
        return 1
    end

    if not tmux display-message -p -t $TMUX_PANE &>/dev/null
        echo "You must start tmux to use tsl."
        return 1
    end

    set -l count $argv[1]
    set -l cmd $argv[2]
    set -l current_dir (pwd)
    set -l panes $TMUX_PANE

    tmux rename-window -t $TMUX_PANE (basename $current_dir)

    while test (count $panes) -lt $count
        set -l split_target $panes[-1]
        set -l new_pane (tmux split-window -h -t $split_target -c $current_dir -P -F '#{pane_id}')
        set -a panes $new_pane
        tmux select-layout -t $panes[1] tiled
    end

    for pane in $panes
        tmux send-keys -t $pane "$cmd" C-m
    end

    tmux select-pane -t $panes[1]
end
