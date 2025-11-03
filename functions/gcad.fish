function gcad --wraps='git commit -a --amend' --description 'alias gcad=git commit -a --amend'
  git commit -a --amend $argv
end
