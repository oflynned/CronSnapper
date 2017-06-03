#!/bin/bash

readonly BASE_DIR=~/Documents/Files/
readonly IMAGES_DIR="${BASE_DIR}images/"

function getJsonValue() {
  python -c "import json,sys;sys.stdout.write(json.dumps(json.load(sys.stdin)$1))";
}

function replaceQuotes() {
  return $1 | sed -e 's/^"//' -e 's/"$//'
}

function generateNotification() {
  sfx="$BASE_DIR/sfx/notification.mp3"
  osascript -e "display notification $3 with title $1 subtitle $2"
  # afplay $sfx
}

function notify() {
  header=$(curl "http://13.94.249.94/api/v1" | getJsonValue "['header']")
  title=$(curl "http://13.94.249.94/api/v1" | getJsonValue "['title']")
  subtitle=$(curl "http://13.94.249.94/api/v1" | getJsonValue "['subtitle']")
  generateNotification "$header" "$title" "$subtitle"
}

function notifyVoice() {
  say "You might want to look behind you."
  sleep 2
  say "It's only a picture for my personal collection. I'll be back soon."
}

function takePicture() {
  mkdir -p ~/Documents/Files/images
  imageName=$(date +%s%N | cut -b1-13)$".png"
  ~/Documents/Files/imagesnap -w 1 ~/Documents/Files/images/$imageName
  open ~/Documents/Files/images/$imageName
}

function main() {
  status=$(curl --silent --output /dev/stderr --write-out "%{http_code}" http://13.94.249.94/api/v1)

  if [[ $status != 200 ]]; then
    exit $status
  else
    should_run=$(curl "http://13.94.249.94/api/v1" | getJsonValue "['should_run']")
    if $should_run; then
      notifyVoice;
      takePicture;
      sleep 1;
      notify;
    fi
  fi
}

main
