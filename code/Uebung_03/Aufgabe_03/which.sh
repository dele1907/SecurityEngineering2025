#!/bin/sh

if [ "$#" -ne 1 ]; then
  echo "Es darf nur genau ein Argument übergeben werden"
  exit 1
fi

for dir in $(echo "$PATH" | tr ':' ' '); do
  if test -x "$dir/$1" ; then
    echo "$dir/$1"
    exit 0
  fi
done

echo "$1 not found"
exit 1