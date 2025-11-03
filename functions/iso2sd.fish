function iso2sd
  if test (count $argv) -ne 2
    echo "Usage: iso2sd <input_file> <output_device>"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    printf "\nAvailable SD cards:\n"
    lsblk -d -o NAME | grep -E '^sd[a-z]' | awk '{print "/dev/"$1}'
  else
    sudo dd bs=4M status=progress oflag=sync if="$argv[1]" of="$argv[2]"
    sudo eject $argv[2]
  end
end
