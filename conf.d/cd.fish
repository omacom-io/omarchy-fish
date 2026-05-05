functions -c cd __original_cd

function cd --wraps=zd --description 'alias cd=zd'
  zd $argv
end

function zd --description 'zoxide-backed cd'
  if test (count $argv) -eq 0
      __original_cd ~; and return
  else if test -d $argv[1]
      __original_cd -- $argv[1]
  else
      z $argv; and printf "\U000F17A9 "; and pwd || echo "Error: Directory not found"
  end
end
