#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/includes/util.sh"
source "$DIR/includes/gedit.sh"

gedit.install
exit 0
