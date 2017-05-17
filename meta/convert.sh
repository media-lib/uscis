#!/usr/bin/env mksh
#
#
set -u -e -o pipefail

# IFS=$'\n'

TITLES="$(cat uscis_test/titles)"
ALBUM="$(echo "$TITLES" | grep 'DTITLE' | cut -d'=' -f2-)"
cd /tmp/uscis
for FILE in $(ls -1 . | grep .wav); do
  NEW_NAME="$(basename "$FILE" .cdda.wav)"
  NEW_NAME="${NEW_NAME/track/}"
  TRACK="${FILE%.cdda.wav}"
  TRACK="${TRACK#track}"
  INDEX="$(( TRACK - 1))"
  TITLE="$(echo "$TITLES" | grep TTITLE$INDEX=)"
  TITLE="${TITLE#TTITLE*=*}"
  # echo $NEW_NAME $TITLE
  oggenc $FILE -q 10 -o "$NEW_NAME".ogg -a "US CIS" -t "$TITLE" -l "$ALBUM"
done
echo ""
echo "=== DONE: $ALBUM"
