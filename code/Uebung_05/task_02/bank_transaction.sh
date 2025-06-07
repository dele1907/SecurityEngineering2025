#!/bin/bash

TAN_DIR="TAN"

# Farben für schöneren Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

# Unterbrechung mit [Strg+C] verhindern (https://openbook.rheinwerk-verlag.de/shell_programmierung/shell_009_002.htm)
#trap '' INT 
#Beenden mit kill <PID>

# Verwendung Lamportsches TAN-Verfahren, da es sehr einfach ist (immer erste TAN verbrauchen)
while true; do
    echo -n "Benutzername: "
    read USERNAME

    echo -n "TAN: "
    read INPUT_TAN

    USER_FILE="${TAN_DIR}/${USERNAME}.tan"

    if [[ ! -f "$USER_FILE" ]]; then
        echo -e "${RED}❌ Zugriff verweigert: Benutzer nicht bekannt ${NC}"
        continue
    fi

    # Lese erste TAN aus Datei
    FIRST_TAN=$(head -n 1 "$USER_FILE")

    if [[ -z "$FIRST_TAN" ]]; then
        echo -e "${RED}❌ Zugriff verweigert: TAN-Liste aufgebraucht ${NC}"
        continue
    fi

    if [[ "$INPUT_TAN" == "$FIRST_TAN" ]]; then
        # Zugriff erlauben
        echo -e "${GREEN}✅ Zugriff erlaubt ${NC}"

        # TAN verbrauchen (erste Zeile löschen)
        tail -n +2 "$USER_FILE" > "$USER_FILE.tmp" && mv "$USER_FILE.tmp" "$USER_FILE"
    else
        echo -e "${RED}❌ Zugriff verweigert: Falsche TAN ${NC}"
    fi
done
