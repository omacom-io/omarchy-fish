function gcm --wraps='git commit -m' --description 'alias gcm=git commit -m'
  git commit -m $argv
end
