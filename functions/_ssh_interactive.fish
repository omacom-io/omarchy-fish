# True for an interactive session: a destination and no remote command. The
# letters are the ssh(1) options that consume a value, so their arguments are
# not mistaken for the destination.
function _ssh_interactive --description 'Test whether an ssh invocation opens an interactive session'
    set -l value_opts BbcDEeFIiJLlmOoPpQRSWw
    set -l invocation $argv
    set -l dest ""
    set -l opts_done false

    while set -q argv[1]
        set -l arg $argv[1]
        set -e argv[1]

        if test $opts_done = false; and test "$arg" = "--"
            set opts_done true
        else if test $opts_done = false; and string match -qr -- '^-.+' $arg
            set -l letters (string split '' -- (string replace -r '^-' '' -- $arg))
            set -l i 1
            set -l n (count $letters)
            while test $i -le $n
                if string match -q -- "*$letters[$i]*" $value_opts
                    # The value is glued to the letter (-p2222) unless the
                    # letter ends the argument, in which case it consumes
                    # the next one (-p 2222).
                    if test $i -eq $n; and set -q argv[1]
                        set -e argv[1]
                    end
                    break
                end
                set i (math "$i + 1")
            end
        else if test -z "$dest"
            set dest $arg
        else
            return 1
        end
    end

    test -n "$dest"; or return 1

    # A RemoteCommand from ssh_config or -o replays on reconnect just like a
    # positional command; ssh -G resolves the effective configuration for this
    # exact invocation without connecting. Fail closed when it cannot resolve,
    # since an undetected RemoteCommand must not replay. The explicit "none"
    # cancels a configured command, and some versions emit it when unset.
    set -l resolved (command ssh -G $invocation 2>/dev/null); or return 1
    set -l commands (string match -ri '^remotecommand ' -- $resolved | string match -vi -- '^remotecommand none$')
    test (count $commands) -eq 0
end
