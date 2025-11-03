function open --description 'Open files with xdg-open'
  xdg-open $argv >/dev/null 2>&1 &
end
