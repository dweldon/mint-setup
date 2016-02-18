atom.execute() {
  util.message 'setting up atom'
  sudo add-apt-repository -y ppa:webupd8team/atom >& /dev/null
  sudo apt-get -qq update
  util.installPackage 'atom'
  util.assertExecutable 'atom'
}
