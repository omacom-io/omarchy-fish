function ls --wraps='eza -lh --group-directories-first --icons=auto' --description 'alias ls=eza -lh --group-directories-first --icons=auto'
  eza -lh --group-directories-first --icons=auto $argv
end
