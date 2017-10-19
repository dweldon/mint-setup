disk.trim() {
  local file1='/tmp/trim'
  local file2='/etc/cron.daily/trim'

cat << 'EOF' > $file1
#!/bin/sh
LOG=/var/log/trim.log
echo "*** $(date -R) ***" >> $LOG
fstrim -v / >> $LOG
EOF

  sudo mv $file1 $file2
  sudo chmod +x $file2
  sudo chown root:root $file2
}

disk.fstab() {
  local file='/etc/fstab'
  sudo cp $file "$file.old"
  sudo sed -i 's/errors=remount/noatime,errors=remount/' $file
  printf 'tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0' | sudo tee -a $file >& /dev/null
}

disk.swapAndWatches() {
  util.append /etc/sysctl.conf 'vm.swappiness = 10' true
  util.append /etc/sysctl.conf 'fs.inotify.max_user_watches = 524288' true
}

disk.hibernate() {
  local file='/etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla'
  sudo cp $file "$file.old"
  sudo sed -i 's/ResultActive=yes/ResultActive=no/g' $file
}

disk.execute() {
  util.message 'adding disk tweaks'

  local option

  if $(sudo hdparm -I /dev/sda | grep -q 'TRIM supported'); then
    echo 'add trim?'
    select option in 'Yes' 'No'; do
      case $option in
          Yes )
            disk.trim
            break;;
          No )
            break;;
      esac
    done
  fi

  echo 'add fstab tweaks (noatime and tmpfs)?'
  select option in 'Yes' 'No'; do
    case $option in
        Yes )
          disk.fstab
          break;;
        No )
          break;;
    esac
  done

  util.progress 'changing swapiness and watches'
  disk.swapAndWatches

  util.progress 'disabling hibernate and suspend'
  disk.hibernate
}
