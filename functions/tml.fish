function tml --description 'Create a tmux layout for dev with editor, ai, and terminal'
  if not set -q TMUX
    tmux new-session "fish -c 'tml $argv[1]; exec fish'"
    return
  end

  set -l current_dir $PWD
  set -l ai $argv[1]

  # Get current pane ID (will become editor pane after splits)
  set -l editor_pane (tmux display-message -p '#{pane_id}')

  # Split window vertically - top 90%, bottom 10%
  tmux split-window -v -p 10 -c "$current_dir"

  # Go back to top pane (editor_pane) and split it horizontally
  tmux select-pane -t "$editor_pane"
  tmux split-window -h -p 30 -c "$current_dir"

  # After horizontal split, cursor is in the right pane (new pane)
  # Get its ID and run ai there
  set -l ai_pane (tmux display-message -p '#{pane_id}')
  tmux send-keys -t "$ai_pane" "$ai" C-m

  # Run nvim in the left pane
  tmux send-keys -t "$editor_pane" "$EDITOR ." C-m

  # Select the nvim pane for focus
  tmux select-pane -t "$editor_pane"
end
