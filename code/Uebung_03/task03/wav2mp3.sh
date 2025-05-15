#!/bin/sh

if test "$#" -ne 1; then
  echo "Es muss genau eine Datei als Argument übergeben werden"
  exit 1
fi

if ! test -e "$1"; then
  echo "Die Datei exisitert nicht oder konnte nicht gefunden werden"
  exit 1
fi

fileinfo=$(file "$1")

if ! echo "$fileinfo" | grep -qi "wave"; then
  echo "Hier handelt es sich nicht um eine WAVE Datei"
  exit 1
fi

output="${1%.wav}.mp3" # Entfernt die .wav Dateiendung und ersetzt sie durch .mp3
ffmpeg -i "$1" "$output"

exit 0