function ff --wraps="fzf --preview 'bat --style=numbers --color=always {}'" --description "alias ff=fzf --preview 'bat --style=numbers --color=always {}'"
  fzf --preview 'bat --style=numbers --color=always {}' $argv
end
