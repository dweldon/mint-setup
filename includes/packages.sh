packages.execute() {
  util.message 'installing packages'

  util.progress 'updating'
  sudo apt-get update > /dev/null

  util.progress 'upgrading'
  sudo apt-get -y upgrade > /dev/null

  local package
  local packages=(chromium-browser pepperflashplugin-nonfree build-essential libssl-dev curl ntp tree meld tofrodos mediainfo gir1.2-gtop-2.0)
  for package in "${packages[@]}"; do
    util.installPackage $package
  done
}
