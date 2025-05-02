#!/bin/zsh

# generate a 128-bit key (32 hexadecimal characters) using /dev/random
echo 'Creating a 128-bit key using /dev/random...'

# generate random data from /dev/random, convert it to hex, and remove spaces
# the `od` command is used to output random data in a hex format
# `-t x4` specifies the output format. This tells `od` to display the data as hexadecimal words, each consisting of 4 bytes (or 8 hex characters)
# `head -1` takes the first line of the output
# `cut -c 17-` removes the first 16 characters to get the exact number of hex digits needed
# `sed` is used to remove spaces that might be included in the hex output
hexkey=$(od -t x4 /dev/random | head -1 | cut -c 17- | sed -e "s/ //g")
echo "Generated Key: $hexkey"
echo '====================================='
echo ''

# calculate the HMAC of the /etc/services file using the generated 128-bit key
# using the `openssl dgst` command to generate a HMAC using SHA-256 hashing algorithm
# `-mac HMAC` tells openssl to use HMAC for authentication
echo 'Calculating HMAC with 128-bit key for /etc/services...'
openssl dgst -sha256 -mac HMAC -macopt hexkey:$hexkey /etc/services
echo '====================================='
echo ''
