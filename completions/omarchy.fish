function __omarchy_complete
    set -l tokens (commandline -opc)

    set -l omarchy_path (command -v omarchy 2>/dev/null); or return 0
    set -l resolved (realpath -- $omarchy_path 2>/dev/null); or set resolved $omarchy_path
    set -l bin_dir (dirname -- $resolved)
    test -d $bin_dir; or return 0

    set -l prefix omarchy
    set -l positional_count 0
    for tok in $tokens[2..]
        test -z "$tok"; and continue
        string match -q -- '-*' $tok; and continue
        set prefix $prefix-$tok
        set positional_count (math $positional_count + 1)
    end

    set -l seen
    for file in $bin_dir/$prefix-*
        test -f $file -a -x $file; or continue
        set -l basename (string replace -r '^.*/' '' -- $file)
        set -l rest (string replace -- $prefix- '' $basename)
        set -l next (string split -m 1 -- - $rest)[1]
        test -n "$next"; or continue
        contains -- $next $seen; and continue
        set -a seen $next
        echo $next
    end

    if test $positional_count -eq 0
        echo commands
        set -a seen commands
    end

    if test (count $tokens) -ge 2 -a "$tokens[2]" = commands
        echo --all
        echo --json
        echo --markdown
        echo --check
        set -a seen --all
    end

    if test -x $bin_dir/$prefix -o (count $seen) -gt 0
        echo --help
    end
end

complete -c omarchy -f -a '(__omarchy_complete)'
