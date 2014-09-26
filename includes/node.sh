node.latest() {
  local url='http://nodejs.org/dist/latest/'
  local pattern1='>node-v.+-linux-x86.tar.gz'
  local pattern2='[0-9]+\.[0-9]+\.[0-9]+'
  echo $(curl --silent "$url" | egrep -o "$pattern1" | egrep -o "$pattern2")
}

node.installModule() {
  local module="$1"

  util.progress "installing $module"
  npm install -g "$module" >& /dev/null
}

node.filename() {
  local version="$1"

  if [ $(util.architecture) = 64 ]; then
    local architecture='x64'
  else
    local architecture='x86'
  fi

  echo "node-v${version}-linux-${architecture}.tar.gz"
}

node.install() {
  local version="$1"

  # default to the latest version
  if [ -z "$version" ]; then
    version=$(node.latest)
  fi

  local filename=$(node.filename "$version")
  local url="http://nodejs.org/dist/v${version}/${filename}"
  local nodeDir="$HOME/local"

  # remove previous installation
  util.progress 'removing'
  rm -rf "$HOME/tmp"
  rm -rf "$HOME/.npm"
  rm -rf "$HOME/.node-gyp"
  rm -rf "$nodeDir"

  # download binaries
  util.progress 'downloading'
  util.wget "$url"
  mkdir -p "$nodeDir"
  tar -C "$nodeDir" --strip-components 1 -xzf "$filename"
  rm "$filename"

  # install modules
  local module
  local modules=(coffee-script coffeelint)
  for module in "${modules[@]}"; do
    node.installModule "$module"
  done

  # symlink to node_modules
  ln -s "$nodeDir/lib/node_modules" "$HOME/.node_modules"
}

node.execute() {
  local nodeDir="$HOME/local/bin"
  local bashrc="$HOME/.bashrc"

  util.message 'installing node'

  # add the node path to .bashrc
  util.progress 'updating .bashrc'
  util.append "$bashrc" '# node.js'
  util.append "$bashrc" "export PATH=$nodeDir:\$PATH"

  # modify the current environment variables
  PATH="$nodeDir:$PATH"

  node.install
  util.assertExecutable 'node'
  util.assertExecutable 'npm'
}
