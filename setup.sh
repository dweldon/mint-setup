#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/includes/util.sh"

setup() {
  local name
  local names=(packages bashrc node meteor ffmpeg gedit git disk fonts)
  for name in "${names[@]}"; do
    source "$DIR/includes/${name}.sh"
    $name.execute
  done
}

setup
exit 0
