node.execute() {
  util.message 'installing node'

  # install nvm
  git clone -q 'https://github.com/creationix/nvm.git' ~/.nvm
  cd ~/.nvm
  git checkout -q `git describe --abbrev=0 --tags`
  source ~/.nvm/nvm.sh

  # update .bashrc
  local bashrc="$HOME/.bashrc"
  util.append "$bashrc" '# nvm'
  util.append "$bashrc" 'export NVM_DIR="$HOME/.nvm"'
  util.append "$bashrc" '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
  util.append "$bashrc"

  # install node
  nvm install node >& /dev/null
  nvm alias default node >& /dev/null

  util.assertExecutable 'node'
  util.assertExecutable 'npm'
}
