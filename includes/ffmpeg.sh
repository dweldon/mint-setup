ffmpeg.execute() {
  util.message 'installing ffmpeg'

  local filename='ffmpeg-release-32bit-static.tar.xz'
  local dirname='ffmpeg'

  util.wget "http://johnvansickle.com/ffmpeg/releases/${filename}"
  mkdir "$dirname"
  tar -C "$dirname" --strip-components 1 -xf "$filename"

  cd "$dirname"
  sudo chown root:root ffmpeg ffprobe
  sudo mv ffmpeg /usr/local/bin/
  sudo mv ffprobe /usr/local/bin/
  cd ../
  rm "$filename"
  rm -rf "$dirname"

  util.assertExecutable 'ffmpeg'
  util.assertExecutable 'ffprobe'
}
