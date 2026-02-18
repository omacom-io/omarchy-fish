function cx --description 'Launch Claude Code in plan mode'
  printf "\033[2J\033[3J\033[H"
  claude --permission-mode=plan --allow-dangerously-skip-permissions $argv
end
