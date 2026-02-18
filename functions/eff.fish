function eff --description 'Open fuzzy find result in editor'
  set -l file (ff)
  and $EDITOR $file
end
