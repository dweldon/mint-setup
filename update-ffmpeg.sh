#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$DIR/includes/util.sh"
source "$DIR/includes/ffmpeg.sh"

ffmpeg.execute
exit 0
