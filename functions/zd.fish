function zd --description 'zoxide-backed cd'
  if test (count $argv) -eq 0
      builtin cd ~; and return
  else if test -d $argv[1]
      builtin cd -- $argv[1]
  else
      z $argv; and printf "\U000F17A9 "; and pwd || echo "Error: Directory not found"
  end
end
