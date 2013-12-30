gedit.install() {
  local lang="$HOME/.local/share/gtksourceview-3.0/language-specs"
  local styles="$HOME/.local/share/gtksourceview-3.0/styles"
  local tools="$HOME/.config/gedit/tools"

  util.progress 'creating directories'
  mkdir -p "$lang"
  mkdir -p "$styles"
  mkdir -p "$tools"

  util.progress 'adding language files'
  pushd "$lang" > /dev/null
  rm -f *.lang
  util.wget 'https://raw.github.com/LearnBoost/stylus/master/editors/gedit/styl.lang'
  util.wget 'https://raw.github.com/lbdremy/gedit-jade/master/jade.lang'
  util.wget 'https://raw.github.com/wavded/gedit-coffeescript/master/coffee_script.lang'
  popd > /dev/null

  util.progress 'adding style files'
  pushd "$styles" > /dev/null
  rm -f *.xml
  util.wget 'https://raw.github.com/wavded/gedit-coffeescript/master/rubycius-mod.xml'
  popd > /dev/null

  util.progress 'adding tools'
  cp "$DIR/tools/run" "$tools"
}

gedit.execute() {
  util.message 'setting up gedit'

  sudo apt-get -y purge gedit gedit-common >& /dev/null
  util.installPackage 'gedit/saucy'
  util.installPackage 'gedit-plugins'

  gedit.install
}
