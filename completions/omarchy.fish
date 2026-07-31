function __omarchy_complete
    set -l tokens (commandline -opc)
    set -l words $tokens[2..-1]

    set -l omarchy_path (command -v omarchy 2>/dev/null); or return 0
    set -l resolved (realpath -- $omarchy_path 2>/dev/null); or set resolved $omarchy_path
    set -l bin_dir (dirname -- $resolved)
    test -d $bin_dir; or return 0

    # Prefix from all words before the current token
    set -l prefix omarchy
    for tok in $words
        test -z "$tok"; and continue
        string match -q -- '-*' $tok; and continue
        set prefix $prefix-$tok
    end

    # Next-level subcommand candidates
    set -l candidates
    for file in $bin_dir/$prefix-*
        test -f $file -a -x $file; or continue
        set -l basename (string replace -r '^.*/' '' -- $file)
        set -l rest (string replace -- $prefix- '' $basename)
        set -l next (string split -m 1 -- - $rest)[1]
        test -n "$next"; or continue
        contains -- $next $candidates; and continue
        set -a candidates $next
    end

    if test (count $words) -eq 0
        contains -- commands $candidates; or set -a candidates commands
    end

    if test (count $words) -ge 1 -a "$words[1]" = commands
        set -a candidates --all --json --markdown --check
    end

    if test (count $candidates) -eq 0
        # Resolve the deepest omarchy-* command file from the typed words
        set -l command_path
        set -l n (count $words)
        while test $n -ge 0
            set -l command_prefix omarchy
            if test $n -ge 1
                for tok in $words[1..$n]
                    test -z "$tok"; and continue
                    string match -q -- '-*' $tok; and continue
                    set command_prefix $command_prefix-$tok
                end
            end
            if test -x $bin_dir/$command_prefix
                set command_path $bin_dir/$command_prefix
                break
            end
            set n (math $n - 1)
        end

        if test -n "$command_path"
            set -l args (grep -m 1 '^# omarchy:args=' $command_path 2>/dev/null)
            set -l argspec (string replace -r '^.*omarchy:args=' '' -- $args)

            # Words after the resolved command are its arguments
            set -l typed_args
            if test (count $words) -gt $n
                set typed_args $words[(math $n + 1)..-1]
            end

            # Alternatives are separated by ' | ', tokens by spaces
            for alt in (string split ' | ' -- $argspec)
                set -l spec (string split -n ' ' -- $alt)
                set -l match true

                for i in (seq (count $typed_args))
                    set -l token
                    if test $i -le (count $spec)
                        set token $spec[$i]
                    end
                    if test -z "$token"
                        set match false
                        break
                    end
                    if string match -qr '^(<.*>|\[.*\])$' -- $token
                        set -l value (string replace -r '^[<[]' '' -- $token | string replace -r '[>\]]$' '')
                        if string match -q '*|*' -- $value
                            if not contains -- $typed_args[$i] (string split '|' -- $value)
                                set match false
                                break
                            end
                        end
                    else if test "$token" != "$typed_args[$i]"
                        set match false
                        break
                    end
                end
                test $match = true; or continue

                set -l k (math (count $typed_args) + 1)
                set -l token
                if test $k -le (count $spec)
                    set token $spec[$k]
                end
                test -n "$token"; or continue

                if string match -qr '^(<.*>|\[.*\])$' -- $token
                    set -l value (string replace -r '^[<[]' '' -- $token | string replace -r '[>\]]$' '')
                    if string match -q '*|*' -- $value
                        for v in (string split '|' -- $value)
                            contains -- $v $candidates; and continue
                            set -a candidates $v
                        end
                    end
                else
                    contains -- $token $candidates; or set -a candidates $token
                end
            end
        end
    end

    if test (count $candidates) -gt 0
        printf '%s\n' $candidates
    end
end

function __omarchy_complete_has_candidates
    set -l candidates (__omarchy_complete)
    test (count $candidates) -gt 0
end

# Suppress file completion only when there are spec/subcommand candidates,
# so free-form <tokens> fall back to file completion like bash's -o default.
complete -c omarchy -n __omarchy_complete_has_candidates -f
complete -c omarchy -a '(__omarchy_complete)'
