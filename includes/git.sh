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
  git config --global push.default simple
  git config --global diff.tool meld
  git config --global merge.tool meld
  git config --global difftool.prompt false
  git config --global core.editor "atom --wait"
  git config --global alias.hist 'log --pretty=format:"%C(yellow)%h%C(reset) %ad %C(green)%s%C(reset) %C(magenta)[%an]%C(reset)%d" --graph --date=short'
  git config --global alias.cleanup '!git remote prune origin && git gc'
  util.assertExecutable 'git'
  util.assertContains "$HOME/.gitconfig" 'hist'
}
