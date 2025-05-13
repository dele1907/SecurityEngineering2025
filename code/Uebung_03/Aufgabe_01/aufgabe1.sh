#!/bin/sh

# Das Kommando ntpdate existiert nicht unter Macos
# Als Alternative kann man sntp verwenden
# Da Manual Page unter Macos nicht verfügbar ist: https://linux.die.net/man/8/ntpdate

# 1)

# ntpdate -q
# ntpdate -d

sntp ntp1.hiz-saarland.de
sntp ptbtime1.ptb.de

# Es gibt scheinbar 3 ntp - Server vom HIZ: https://www.hiz-saarland.de/dienste/zeitsync 
# Für die physikalisch-technische Bundesanstalt scheinen es 4 zu sein: https://www.ptb.de/cms/ptb/fachabteilungen/abt9/gruppe-95/ref-952/zeitsynchronisation-von-rechnern-mit-hilfe-des-network-time-protocol-ntp.html

# 10 weitere ntp - Server sind:
# 1. ntp1.t-online.de (T-Online)
# 2. ntp.web.de (web.de)
# 3. time1.uni-paderborn.de (Uni Paderborn)
# 4. time.fu-berlin.de (FU Berlin)
# 5. npt3.informatik.uni-erlangen.de (Uni Erlangen)
# 6. amazon.pool.ntp.org (Amazon)
# 7. time.cloudfare.com (cloudfare)
# 8. time.facebook.com (Meta)
# 9. time.windows.com (Microsoft)
# 10. time.apple.com (Apple)