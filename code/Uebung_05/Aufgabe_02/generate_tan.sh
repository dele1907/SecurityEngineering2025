#!/bin/sh

re='^[0-9]+$'
username="$1"
number_of_tans="$2"

if test $# -ne 2; then
  echo "usage: $0 <username> <number_of_tans>"
  exit 1
fi

if ! echo "$number_of_tans" | grep -Eq "$re" || test "$number_of_tans" -le 0; then
  echo "Error: Second argument 'number_of_tans' must be an integer greater than 0."
  exit 1
fi

directory_name="$username.TAN"
filename="tan"
path="$directory_name/$filename"

echo $path

if ! test -d ./"$directory_name"; then
  mkdir -p "$directory_name"
fi

rm -rf "$path" # wird jedes mal gelöscht 

for ((i = 0; i < $number_of_tans; i++)); do
  #eigentlich nicht richtig, man muss die tans chainen,
  #der n-te tan ist abhängig von dem n-1ten, man kann
  #das machen, indem man zb. mit sha256sum den letzten hash
  #hashed
  tan=$(openssl rand -hex 4)
  echo "$tan" >> "$path"
done




    
    