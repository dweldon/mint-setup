git.execute() {
  util.message 'installing git'
  util.installPackage 'git'

  local name
  local email
  echo 'What is your full name?'
  read name
  echo 'What is your email?'
  read email

  git config --global user.name "$name"
  git config --global user.email "$email"
  git config --global color.ui auto
  git config --global push.default matching
  git config --global alias.hist 'log --pretty=format:"%C(yellow)%h%C(reset) %ad %C(green)%s%C(reset) %C(magenta)[%an]%C(reset)%d" --graph --date=short'
  util.assertExecutable 'git'
  util.assertContains "$HOME/.gitconfig" 'hist'
}
