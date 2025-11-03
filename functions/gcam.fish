function gcam --wraps='git commit -a -m' --description 'alias gcam=git commit -a -m'
  git commit -a -m $argv
end
