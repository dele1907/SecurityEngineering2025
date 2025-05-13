# Übersicht: ntpdate Optionen und Serverinformationen

Die Manpage ist auch nach Installation mittels Homebrew nicht vorhanden.
Abrufbar unter: 
<a href="https://manpages.debian.org/bookworm/ntpsec-ntpdate/ntpdate.8.en.html">Manpage bei debian.org</a>

Diese Datei gibt eine kurze Übersicht über wichtige Optionen des Befehls `ntpdate` sowie über verfügbare Server zur Zeitsynchronisation.

## Zusammenfassung

| **Teilfrage**                               | **Antwort**                                                                                                   |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------|
| **Welche Option verhindert Zeitänderung?**  | `-q` – Diese Option sorgt dafür, dass keine tatsächliche Zeitänderung am System vorgenommen wird.             |
| **Welche Option aktiviert Debug-Ausgaben?** | `-d` – Aktiviert den Debug-Modus, zeigt detaillierte Informationen über die Kommunikation mit dem Server.     |
| **Befehl zur Kontaktaufnahme mit Servern**  | `ntpdate -q -d ntp1.hiz-saarland.de ptbtime1.ptb.de` – Testet Verbindung und Ausgabe ohne Zeitänderung.       |
| **Wieviele offiziell erreichbare NTP-Server?** | **4 Server bei der PTB**: `ptbtime1.ptb.de`, `ptbtime2.ptb.de`, `ptbtime3.ptb.de`, `ptbtime4.ptb.de`.<br>**Weiter auf HIZ-Seite 3 Server:** `ntp1.hiz-saarland.de`, `ntp2.hiz-saarland.de`, `ntp3.hiz-saarland.de` (Die genaue Anzahl kann mit `dig` abgefragt werden.) |

## Beispiel: Abfrage mit `dig`

```bash
dig +short ntp1.hiz-saarland.de
dig +short ptbtime1.ptb.de
```

## Abfragen mittels ntpdate:

```bash
ntpdate -q -d ntp1.hiz-saarland.de
ntpdate -q -d ptbtime1.ptb.de
```

## 10 Weitere NTP-Server (öffentlich erreichbar):

| **Nr.** | **Hostname**                            | **Betreiber / Organisation**       |
|--------:|------------------------------------------|------------------------------------|
| 1       | `time.windows.com`                      | Microsoft                          |
| 2       | `ntp1.t-online.de`                      | T-Online                           |
| 3       | `time.apple.com`                        | Apple                              |
| 4       | `ntp.web.de`                            | web.de                             |
| 5       | `time.facebook.com`                     | Meta / Facebook                    |
| 6       | `time1.uni-paderborn.de`                | Universität Paderborn              |
| 7       | `npt3.informatik.uni-erlangen.de`       | Universität Erlangen               |
| 8       | `time.fu-berlin.de`                     | Freie Universität Berlin           |
| 9       | `amazon.pool.ntp.org`                   | Amazon                             |
| 10      | `time.cloudflare.com`                   | Cloudflare                         |