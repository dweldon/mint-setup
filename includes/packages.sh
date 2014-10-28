packages.execute() {
  util.message 'installing packages'

  local package
  local packages=(chromium-browser pepperflashplugin-nonfree build-essential libssl-dev curl ntp tree meld tofrodos mediainfo gir1.2-gtop-2.0)
  for package in "${packages[@]}"; do
    util.installPackage $package
  done
}
