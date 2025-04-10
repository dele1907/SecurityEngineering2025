#!/bin/bash

GERMAN="deutsch.txt"
ENGLISH="englisch.txt"

calculate_entropy() {
  local file=$1
  local language=$2

  if [ ! -f "$file" ]; then
    echo "File '$file' for language '$language' not found."
    return
  fi

  count=$(wc -l < "$file")
  entropy=$(echo "scale=4; l($count)/l(2)" | bc -l)

  echo "Language '$language' with $count words: $entropy bits of entropy"
}

calculate_entropy "$GERMAN" "German"
calculate_entropy "$ENGLISH" "English"