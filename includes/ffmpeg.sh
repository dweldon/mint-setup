ffmpeg.execute() {
  util.message 'installing ffmpeg'

  local filename='ffmpeg.static.32bit.latest.tar.gz'

  util.wget "http://ffmpeg.gusari.org/static/32bit/${filename}"
  tar -xzf "$filename"
  sudo chown root:root ffmpeg ffprobe
  sudo mv ffmpeg /usr/local/bin/
  sudo mv ffprobe /usr/local/bin/
  rm "$filename"

  util.assertExecutable 'ffmpeg'
  util.assertExecutable 'ffprobe'
}
