function _fzf_search_history --description 'Search command history. Replace the command line with the selected command.'
  # history merge incorporates history changes from other fish sessions
  # it errors out if called in private mode
  if test -z "$fish_private_mode"
    builtin history merge
  end

  # Get history without timestamps or separators
  set -f commands_selected (
    builtin history --null |
    _fzf_wrapper --read0 \
      --print0 \
      --multi \
      --scheme=history \
      --prompt="> " \
      --query=(commandline) \
      --preview="echo {} | fish_indent --ansi" \
      --preview-window="top:3:wrap" \
      $fzf_history_opts |
    string split0
  )

  if test $status -eq 0
    commandline --replace -- $commands_selected
  end

  commandline --function repaint
end
