# Create multiple hdl tabs with one per subdirectory in the current directory
# Usage: hdlm <c|cx|codex|other_ai> [<second_ai>]
function hdlm
    if test -z "$argv[1]"
        echo "Usage: hdlm <c|cx|codex|other_ai> [<second_ai>]"
        return 1
    end
    if test -z "$HERDR_PANE_ID"
        echo "You must start herdr to use hdlm."
        return 1
    end

    set -l ai $argv[1]
    set -l ai2 $argv[2]
    set -l base_dir (pwd)
    set -l first true

    # Rename the workspace to the current directory name
    herdr workspace rename $HERDR_WORKSPACE_ID (basename $base_dir) >/dev/null

    for dir in $base_dir/*/
        test -d $dir; or continue
        set -l dirpath (string replace -r '/$' '' -- $dir)

        set -l hdl_command "hdl "(string escape -- $ai)
        if test -n "$ai2"
            set hdl_command "$hdl_command "(string escape -- $ai2)
        end

        if test $first = true
            # Reuse the current tab for the first project
            herdr pane run $HERDR_PANE_ID "cd "(string escape -- $dirpath)" && $hdl_command" >/dev/null
            set first false
        else
            set -l pane_id (herdr tab create --workspace $HERDR_WORKSPACE_ID --cwd $dirpath --no-focus |
                jq -r '.result.root_pane.pane_id')
            herdr pane run $pane_id "$hdl_command" >/dev/null
        end
    end
end
