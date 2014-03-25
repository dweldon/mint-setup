packages.execute() {
  util.message 'installing packages'

  util.progress 'updating'
  sudo apt-get update > /dev/null

  util.progress 'upgrading'
  sudo apt-get -y upgrade > /dev/null

  local package
  local packages=(chromium-browser build-essential libssl-dev curl ntp tree meld tofrodos mediainfo)
  for package in "${packages[@]}"; do
    util.installPackage $package
  done
}
