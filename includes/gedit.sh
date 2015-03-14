gedit.install() {
  local plugins="$HOME/.local/share/gedit/plugins"
  local lang="$HOME/.local/share/gtksourceview-3.0/language-specs"
  local styles="$HOME/.local/share/gtksourceview-3.0/styles"
  local tools="$HOME/.config/gedit/tools"

  util.progress 'creating directories'
  mkdir -p "$plugins"
  mkdir -p "$lang"
  mkdir -p "$styles"
  mkdir -p "$tools"

  util.progress 'adding plugins'
  pushd "$plugins" > /dev/null

  rm -rf gedit-file-search
  util.wget 'https://github.com/oliver/gedit-file-search/releases/download/GEDIT_FILE_SEARCH_V1.2/gedit-file-search-1.2.tgz'
  tar xzf gedit-file-search-*

  rm -rf gedit-fullscreen-margins-*
  util.wget 'https://github.com/sergejx/gedit-fullscreen-margins/archive/v1.0.tar.gz' 'gedit-fullscreen-margins.tgz'
  tar xzf gedit-fullscreen-margins.tgz

  rm *.tgz
  popd > /dev/null

  util.progress 'adding language files'
  pushd "$lang" > /dev/null
  rm -f *.lang
  util.wget 'https://raw.githubusercontent.com/dweldon/gedit-stylus/master/styl.lang'
  util.wget 'https://raw.githubusercontent.com/lbdremy/gedit-jade/master/jade.lang'
  util.wget 'https://raw.githubusercontent.com/wavded/gedit-coffeescript/master/coffee_script.lang'
  popd > /dev/null

  util.progress 'adding style files'
  pushd "$styles" > /dev/null
  rm -f *.xml
  util.wget 'https://raw.githubusercontent.com/wavded/gedit-coffeescript/master/rubycius-mod.xml'
  util.wget 'https://wiki.gnome.org/Projects/GtkSourceView/StyleSchemes?action=AttachFile&do=get&target=build.xml' 'build.xml'
  util.wget 'https://wiki.gnome.org/Projects/GtkSourceView/StyleSchemes?action=AttachFile&do=get&target=solarized_light.xml' 'solarized_light.xml'
  popd > /dev/null

  util.progress 'adding tools'
  cp "$DIR/tools/run" "$tools"
}

gedit.execute() {
  util.message 'setting up gedit'

  sudo apt-get -y purge gedit gedit-common >& /dev/null
  util.installPackage 'gedit/trusty'
  util.installPackage 'gedit-plugins/trusty'

  gedit.install
}
