#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/includes/util.sh"
source "$DIR/includes/node.sh"

node.install $1
exit 0
