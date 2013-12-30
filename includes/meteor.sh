meteor.execute() {
  util.message 'installing meteor'
  curl -s https://install.meteor.com | /bin/sh >& /dev/null
  util.assertExecutable 'meteor'
}
