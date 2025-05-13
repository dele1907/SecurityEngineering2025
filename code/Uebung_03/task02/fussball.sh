#!/bin/sh

ORIGINAL_FILE="fussball-tabelle.html"
DUPLICATE_FILE="fussball-tabelle2.html"
OUTPUT_FILE="vereinsliste.txt"

# 1. Prüfen, ob Originaldatei existiert
if ! test -e "$ORIGINAL_FILE"; then
  echo "Ursprungsdatei konnte nicht gefunden werden"
  exit 1
fi

# 2. Alte Kopie löschen, falls vorhanden
[ -e "$DUPLICATE_FILE" ] && rm "$DUPLICATE_FILE"

# 3. th durch td ersetzen
sed -e "s:<th\>:<td\>:g" -e "s:</th>:</td>:g" "$ORIGINAL_FILE" > "$DUPLICATE_FILE"

# 4. Ausgabe der Unterschiede
echo "Differenz der beiden Dateien:"
diff -u "$ORIGINAL_FILE" "$DUPLICATE_FILE"

# 5. Vereinsnamen in Reihenfolge extrahieren
    # grep command: Sucht nach Zeilen mit dem Muster '<a class="ellipsis"' in der Datei.
    # sed command: Extrahiert den sichtbaren Linktext nach einem leeren <span>-Tag innerhalb eines <a>-Tags. -E aktiviert die erweiterte Syntax.
    # nl command: Nummeriert die extrahierten Vereinsnamen.
grep '<a class="ellipsis"' "$DUPLICATE_FILE" | \
sed -E 's/.*<span[^>]*><\/span>[[:space:]]*([^<]+)[[:space:]]*<\/a>.*/\1/' | \
nl -w1 -s'. ' > "$OUTPUT_FILE"

# 6. Ausgabe anzeigen
bat "$OUTPUT_FILE"
