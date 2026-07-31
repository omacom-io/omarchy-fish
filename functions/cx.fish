function cx --description 'Launch Claude Code with bypassPermissions mode'
    printf "\033[2J\033[3J\033[H"
    claude --permission-mode bypassPermissions $argv
end
