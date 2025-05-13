#!/bin/bash

# Prüfen, ob genau ein Programmname übergeben wurde -> wenn nicht Benutzungsanleitung
if [ $# -ne 1 ]; then
  echo "Benutzung: $0 PROGRAMMNAME"
  exit 1
fi

# übergebenes Argument in Variablen speichern
PROGRAMM="$1"

# PATH-Variable auslesen
# IFS (Internal Field Separator) ist eine Umgebungsvariable, die den Trennzeichen für die Eingabe- und Ausgabeoperationen definiert
# Hier wird IFS auf ':' gesetzt, um den PATH in Verzeichnisse zu unterteilen, da in dem Pfad die Verzeichnisse durch ':' getrennt sind
# in Verzeichnis-Array werden die Verzeichnisse gespeichert
IFS=':' read -r -a VERZEICHNISSE <<< "$PATH"

# PATH-Verzeichnisse durchsuchen
# "${VERZEICHNISSE[@]}" gibt alle Elemente des Arrays aus
# wenn ein ausführbares Programm gefunden wird, wird der Pfad ausgegeben
for VERZ in "${VERZEICHNISSE[@]}"; do
  if [ -x "$VERZ/$PROGRAMM" ]; then
    echo "$VERZ/$PROGRAMM"
    exit 0
  fi
done

# Nichts gefunden
echo "$PROGRAMM nicht gefunden"
exit 1
