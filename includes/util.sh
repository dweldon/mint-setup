util.append() {
  local path="$1"
  local text="$2"
  local root="$3"

  if [ -z "$root" ]; then
    printf "\n$text" >> "$path"
  else
    printf "\n$text" | sudo tee -a "$path" >& /dev/null
  fi
}

util.architecture() {
  if [ $(uname -m) = 'x86_64' ]; then
    echo 64
  else
    echo 32
  fi
}

util.assertContains() {
  local path="$1"
  local string="$2"
  $(grep -q "$string" "$path") || util.fail "$path does not contain $string"
}

util.assertExecutable() {
  local filename="$1"
  hash "$filename" >& /dev/null || util.fail "$filename not installed"
}

util.assertExists() {
  local path="$1"

  if [ ! -f $path ]; then
    util.fail "$path does not exist"
  fi
}

util.fail() {
  local message="$1"
  echo "ERROR: $message" && exit 1
}

util.installPackage() {
  local name="$1"
  util.progress "installing $name"
  sudo apt-get -y install "$name" >& /dev/null
}

util.message() {
  local message="$1"
  echo "- $message"
}

util.progress() {
  local message="$1"
  printf "\t%s\n" "$message"
}

util.wget() {
  local url="$1"
  wget -q --no-check-certificate "$url"
}
