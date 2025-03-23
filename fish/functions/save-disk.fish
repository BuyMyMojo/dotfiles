function save-disk --wraps='dd if=/dev/sr0 | pv -pteabW -s $(lsblk -b --output SIZE -n -d /dev/sr0) | cat >' --description 'alias save-disk=dd if=/dev/sr0 | pv -pteabW -s $(lsblk -b --output SIZE -n -d /dev/sr0) | cat >'
  dd if=/dev/sr0 | pv -pteabW -s $(lsblk -b --output SIZE -n -d /dev/sr0) | cat > $argv
        
end
