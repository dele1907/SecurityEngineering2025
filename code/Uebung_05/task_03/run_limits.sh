#!/bin/bash

EXIT_FAILURE=1
EXIT_SUCCESS=0

# Farben für schöneren Output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

set_limits() {
    echo
    echo "🎛️  Setze Limits für das Skript..."
    ulimit -t 2  # CPU-Zeitlimit = 2 Sekunden
    ulimit -s 64 # stack Limit = 64 KB
    ulimit -f 1  # Dateigröße = 1 KB
    ulimit -a | grep -E 'cpu|stack|file' # Zeige die gesetzten Limits an
    echo
    echo -e "${GREEN}✅ Limits gesetzt. ${NC}"
}

if [ $# -eq 0 ]; then
    echo -e "${RED}❌ Fehler:Bitte gib mindestens einen Parameter an: 'cpu', 'stack' oder 'file'. ${NC}"
    exit $EXIT_FAILURE
fi

# Überprüfen, ob das Programm existiert
if [[ ! -f "limits_try_out" ]]; then
    echo -e "${RED}❌ Fehler: Das Programm 'limits_try_out' existiert nicht im aktuellen Verzeichnis. ${NC}"

    if [[ -f "limits_try_out.c" ]]; then
        echo -e "${RED}❗️ Hinweis: Stelle sicher, dass du das Programm kompiliert hast. Führe 'gcc limits_try_out.c -o limits_try_out' aus. ${NC}"
    else
        echo -e "${RED}❗️ Hinweis: Die Quelldatei 'limits_try_out.c' fehlt. Bitte stelle sicher, dass sie im aktuellen Verzeichnis vorhanden ist. ${NC}"
    fi
    
    exit $EXIT_FAILURE
fi

for TEST in "$@"; do
    echo "__________________________________________________________________"
    echo
    echo "▶️  Starte Test für: $TEST"
    set_limits

    # Überprüfen, ob das Programm ausführbar ist
    if [[ ! -x "limits_try_out" ]]; then
        echo -e "${RED}❌ Fehler: Das Programm 'limits_try_out' ist nicht ausführbar. ${NC}"
        exit $EXIT_FAILURE
    fi

    ./limits_try_out "$TEST"
    STATUS=$?

    echo
    echo "📤 Rückgabewert von limits_try_out: $STATUS"
    echo
    echo -e "${GREEN}✅ Test für '$TEST' abgeschlossen. ${NC}"
    echo "__________________________________________________________________"
    echo
done
echo -e "${GREEN}✅✅ Alle Tests abgeschlossen. ${NC}"
exit $EXIT_SUCCESS