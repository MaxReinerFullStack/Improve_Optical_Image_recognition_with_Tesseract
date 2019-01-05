#!/bin/bash
# PROGRAM=myocr.sh
if [ $# -ge 3 ]; then
  TMPF=$(mktemp myocr.sh.XXXXXXXX.tif)
  DEST="$2"
  LANG="$3"
  if [ ! "$DEST" ]; then
    DEST="${1%.*}.txt"
    if [ -e "$DEST" ]; then
      echo "$DEST already exists; please provide a new textfile name" >&2
      exit 1
    fi
  fi
  /usr/bin/convert "$1" -colorspace Gray -depth 8 -resample 200x200 -flatten -alpha Off $TMPF \
  && /usr/bin/tesseract $TMPF "$DEST" -l="$LANG"
  EX=$?
  /bin/rm -f $TMPF
  [ $EX -eq 0 ] && [ "$TERM" ] && echo "created $DEST"
  exit $EX
else
  echo "Usage: $0 imagefile textfile language" >&2
  echo " creates a plain text file and a language with the text found in imagefile" >&2
  exit 1
fi
