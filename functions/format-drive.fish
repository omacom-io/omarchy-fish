function format-drive
  if test (count $argv) -ne 2
    echo "Usage: format-drive <device> <name>"
    echo "Example: format-drive /dev/sda 'My Stuff'"
    printf "\nAvailable drives:\n"
    lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
  else
    set device $argv[1]
    set label $argv[2]
    echo "WARNING: This will completely erase all data on $device and label it '$label'."
    read -P "Are you sure you want to continue? (y/N): " confirm
    if string match -qr '^[Yy]$' -- $confirm
      sudo wipefs -a $device
      sudo dd if=/dev/zero of="$device" bs=1M count=100 status=progress
      sudo parted -s $device mklabel gpt
      sudo parted -s $device mkpart primary ext4 1MiB 100%
      if string match -q '*nvme*' -- $device
        set part (string join '' $device 'p1')
      else
        set part (string join '' $device '1')
      end
      sudo mkfs.ext4 -L "$label" "$part"
      set mount "/run/media/$USER/$label"
      sudo chmod -R 777 "$mount"
      echo "Drive $device formatted and labeled '$label'."
    end
  end
end
