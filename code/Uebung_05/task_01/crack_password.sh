#!/bin/bash

EXIT_SUCCESS=0
EXIT_FAILURE=1

# Wörterbuch (lokale Kopie vom gegebenen Link)
WORDLIST="words.txt"
# Farben für schöneren Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

# Benutzer + gehashte Passwörter (Format: Name;Hash)
USERS=(
    "Steffi.Jones;\$1\$O7v0C21Z\$2FH7ib2Dxtoq6B83qTgON1"
    "Marco.Reus;\$1\$Jebn3vQ5\$2k..iqxtXNwfsCFAamWCS0"
    "Almuth.Schult;\$1\$0ngrMRa1\$uXLzWhnrYzmiRM3fi8Nde1"
    "Manuel.Neuer;\$1\$1aaPttrp\$VoF2rkOyC/tE.DxzQuuIY1"
    "Birgit.Prinz;\$1\$7ieEwjFr\$T/jwatbzqhLZNVDEfymB41"
)

# Überprüfen, ob die Wörterbuchdatei existiert
if [[ ! -f "$WORDLIST" ]]; then
    echo -e "${RED}❌ Fehler: Wörterbuchdatei '$WORDLIST' nicht gefunden!${NC}"
    exit $EXIT_FAILURE
fi

echo "Starte Dictionary-Attacke..."

for entry in "${USERS[@]}"; do
    NAME="${entry%%;*}"
    HASH="${entry##*;}"
    SALT=$(echo "$HASH" | cut -d'$' -f3)
    TARGET_HASH="$HASH"

    echo -e "\n🔍 Suche Passwort für $NAME (Salt: $SALT)"

    FOUND=0
    while read -r WORD; do #HINT -r -> raw input, keine Escape-Sequenzen
        #HINT -1 -> MD5
        TEST_HASH=$(openssl passwd -1 -salt "$SALT" "$WORD")
        if [[ "$TEST_HASH" == "$TARGET_HASH" ]]; then
            echo -e "${GREEN}✅ Gefunden: $NAME → Passwort ist '$WORD'${NC}"
            FOUND=1
            break
        fi
    done < "$WORDLIST"

    if [[ $FOUND -eq 0 ]]; then
        echo -e "${RED}❌ Kein Passwort gefunden für $NAME${NC}"
    fi
done

echo -e "\n✅ Attacke wurde ausgeführt."
exit $EXIT_SUCCESS

