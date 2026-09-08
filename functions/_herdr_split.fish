function _herdr_split --description 'Split a herdr pane and echo the id of the new pane'
    herdr pane split $argv[1] --direction $argv[2] --ratio $argv[3] --cwd $argv[4] --no-focus |
        jq -r '.result.pane.pane_id'
end
