# Define try function manually to fix Fish shell compatibility issues
# Solves issues addressed in open PR: https://github.com/tobi/try/pull/39
function try
    set -l script_path /usr/bin/try
    set -l tries_path ~/Work/tries

    set -l cmd
    switch "$argv[1]"
        case clone worktree init
            set cmd (/usr/bin/env ruby "$script_path" --path "$tries_path" $argv 2>/dev/tty | string collect)
        case '*'
            set cmd (/usr/bin/env ruby "$script_path" cd --path "$tries_path" $argv 2>/dev/tty | string collect)
    end
    set -l rc $status

    if test $rc -eq 0
        if string match -q "*try something!*" -- $cmd
            printf "%s\n" $cmd
        else
            eval $cmd
        end
    else
        printf "%s\n" $cmd
    end
end
