#!/bin/bash

EXIT_SUCCESS=0
EXIT_FAILURE=1

# Farben für schöneren Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

USERNAME="$1"
COUNT="$2"
TAN_DIR="TAN"
USER_FILE="${TAN_DIR}/${USERNAME}.tan"

if [[ -z "$USERNAME" || -z "$COUNT" || ! "$COUNT" =~ ^[0-9]+$ ]]; then
    echo -e "${RED}❌ Fehler: Usage: $0 <username> <anzahl> ${NC}"
    echo "Beispiel: $0 Steffi.Jones 5"
    exit $EXIT_FAILURE
fi


if [[ "$COUNT" -le 0 ]]; then
    echo -e "${RED}❌ Fehler: Die Anzahl der TANs muss größer als 0 sein. ${NC}"
    exit $EXIT_FAILURE
fi

mkdir -p "$TAN_DIR"

# Alte TAN-Datei löschen, falls existent
> "$USER_FILE"

for ((i = 0; i < COUNT; i++)); do
    # Jede TAN = zufälliger 8-stelliger Code
    TAN=$(openssl rand -hex 4)  # ergibt 8 Zeichen
    echo "$TAN" >> "$USER_FILE"
done

echo -e "${GREEN}✅ TAN-Liste für $USERNAME erstellt unter $USER_FILE ${NC}"
bat ./TAN/"$USERNAME".tan
exit $EXIT_SUCCESS
