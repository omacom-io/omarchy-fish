function ff --wraps=fzf --description 'fzf with bat preview; kitty icat for images under xterm-kitty'
    if test "$TERM" = xterm-kitty
        fzf --preview 'if string match -q "image/*" -- (file --mime-type -b {}); kitty icat --clear --transfer-mode=memory --stdin=no --place={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}@0x0 {}; else; bat --style=numbers --color=always {}; end' $argv
    else
        fzf --preview 'bat --style=numbers --color=always {}' $argv
    end
end
