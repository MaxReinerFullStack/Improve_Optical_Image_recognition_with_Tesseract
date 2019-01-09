#!/bin/bash
# PROGRAM=myocr.sh
if [ $# -ge 3 ]; then
    if [[ ! -e temp_result ]];
    then
      mkdir -p temp_result
    fi
  mkdir temp_result
  TMPF=$(mktemp temp_result/myocr.sh.XXXXXXXX.png)
  TMPF2=$(mktemp temp_result/myocr.sh.XXXXXXXXX.png)
  TMPF3=$(mktemp temp_result/myocr.sh.XXXXXXXXXX.png)
  DEST="$2"
  LANG="$3"
  if [ ! "$DEST" ]; then
    DEST="${1%.*}.txt"
    if [ -e "$DEST" ]; then
      echo "$DEST already exists; please provide a new textfile name" >&2
      exit 1
    fi
  fi
   /usr/bin/convert "$1" -density 288 $TMPF
   /usr/sbin/textcleaner -g -e stretch -f 50 -o 10 -s 1 $TMPF $TMPF2
   /usr/bin/tesseract $TMPF2 "$DEST" -l="$LANG"
  EX=$?
  /bin/rm -f $TMPF
  [ $EX -eq 0 ] && [ "$TERM" ] && echo "created $DEST"
  exit $EX
else
  echo "Usage: $0 imagefile textfile language" >&2
  echo " creates a plain text file and a language with the text found in imagefile" >&2
  exit 1
fi
