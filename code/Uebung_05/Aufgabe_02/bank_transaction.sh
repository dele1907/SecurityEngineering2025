#!/bin/sh
trap "" SIGINT

while true; do
  read -p "Username: " username
  read -p "Tan: " entered_tan

  directory_name="$username.TAN"
  filename="$directory_name/tan"

  if ! test -d "$directory_name" || ! test -s "$filename"; then
    echo "error occured, make sure directory for user exists tans exist"
    exit 1
  fi

  #nur der erste tan ist valid,
  valid_tan=$(head -n 1 $filename)
  
  if test "$valid_tan" == "$entered_tan"; then
    echo "acces allowed"
    tail -n +2 "$filename" > "$filename.tmp" && mv "$filename.tmp" "$filename"
  fi
done
