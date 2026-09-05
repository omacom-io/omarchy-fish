function cx --description 'Launch Claude Code with auto permission mode'
    printf "\033[2J\033[3J\033[H"
    claude --permission-mode auto $argv
end
