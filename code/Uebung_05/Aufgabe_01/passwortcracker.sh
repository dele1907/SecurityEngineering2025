#!/bin/sh

wordlist="/usr/share/dict/words"
data="./data.txt"

if ! test -f "$wordlist" || ! test -f "$data"; then
  echo "Dateien konnten nicht gefunden werden"
  exit 1
fi

while read -r name hash; do
  salt=$(echo "$hash" | cut -d'$' -f3)
  hashed_password=$(echo "$hash" | cut -d'$' -f4)

  while read -r word; do
    password=$(openssl passwd -1 -salt "$salt" "$word" | cut -d'$' -f4)

    if test "$password" = "$hashed_password"; then
      echo "$name hat Passwort: $word (Salt: $salt)"
      break
    fi
  done < "$wordlist"

done < "$data"