#!/bin/sh

# Überprüfen, ob mindestens ein Argument übergeben wurde -> $# = Anzahl Argumente
if [ "$#" -eq 0 ]; then
  echo "Fehler: Keine Argumente übergeben."
  exit 1
fi

# Schleife über alle übergebenen Argumente
# "$@" alle Argumente als einzelne Wörter
for name in "$@"
do
  echo "Hallo $name"
  # Prüfen, ob der vorherige Befehl erfolgreich war
  if [ $? -ne 0 ]; then
    echo "Fehler beim Ausgeben von: Hallo $name"
    exit 1
  fi
done

# Erfolgreiches Beenden
exit 0
