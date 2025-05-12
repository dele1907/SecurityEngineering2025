#!/bin/sh

if test "$#" -eq 0; then
  echo "Es darf nur genau eine Datei übergeben werden"
  exit 1
fi

if ! test -e "$1"; then
  echo "Datei existiert nicht"
  exit 1
fi

fileinfo=$(file "$1")

if echo "$fileinfo" | grep -qi "opendocument text"; then
  soffice "$1" # Funkioniert natürlich nur, wenn open office richtig installiert ist, muss nachinstalliert werden
  exit 0
elif echo "$fileinfo" | grep -qi "unicode text" || echo "$fileinfo" | grep -qi "utf-8 text"; then
  less "$1"
  exit 0
elif echo "$fileinfo" | grep -qi "pdf"; then
  xpdf "$1" # Musste unter Macos nachinstalliert werden
  exit 0
elif echo "$fileinfo" | grep -qi "image"; then
  open "$1" #Es gibt keinen einfachen Image Viewer für Macos, der Befehl bei unix/linux/bsd: xv "$1"
  exit 0
fi
