Using Tesseract, you can convert any kind of photographed newspaper article into plain digitized text.

You can do this very fast using a smartphone, or a low dpi scanner or camera with a lower resolution.

Your computer will use lots of RAM for the conversion process into a black white image anyway.

You can also improve the recognition rate by compiling Tesseract either with your Radeon GPU or one or multiple your NVIDIA GPU(s).

https://devtalk.nvidia.com/default/topic/995249/gpu-accelerated-libraries/tesseract-with-cuda/

https://github.com/tesseract-ocr/#git%2Fopencl

I have also achieved very good results using a smartphone, a image convert command and tesseract for the CPU in Linux.

To install tesseract in linux, use the folling command:

apt-get install -y tesseract-ocr-all

In Debian 9, the following additional language packages will be installed:
  tesseract-ocr-afr tesseract-ocr-amh tesseract-ocr-ara tesseract-ocr-asm tesseract-ocr-aze tesseract-ocr-aze-cyrl tesseract-ocr-bel tesseract-ocr-ben tesseract-ocr-bod tesseract-ocr-bos tesseract-ocr-bul
  tesseract-ocr-cat tesseract-ocr-ceb tesseract-ocr-ces tesseract-ocr-chi-sim tesseract-ocr-chi-tra tesseract-ocr-chr tesseract-ocr-cym tesseract-ocr-dan tesseract-ocr-dan-frak tesseract-ocr-deu
  tesseract-ocr-deu-frak tesseract-ocr-dzo tesseract-ocr-ell tesseract-ocr-enm tesseract-ocr-epo tesseract-ocr-est tesseract-ocr-eus tesseract-ocr-fas tesseract-ocr-fin tesseract-ocr-fra tesseract-ocr-frk
  tesseract-ocr-frm tesseract-ocr-gle tesseract-ocr-gle-uncial tesseract-ocr-glg tesseract-ocr-grc tesseract-ocr-guj tesseract-ocr-hat tesseract-ocr-heb tesseract-ocr-hin tesseract-ocr-hrv tesseract-ocr-hun
  tesseract-ocr-iku tesseract-ocr-ind tesseract-ocr-isl tesseract-ocr-ita tesseract-ocr-ita-old tesseract-ocr-jav tesseract-ocr-jpn tesseract-ocr-kan tesseract-ocr-kat tesseract-ocr-kat-old tesseract-ocr-kaz
  tesseract-ocr-khm tesseract-ocr-kir tesseract-ocr-kor tesseract-ocr-kur tesseract-ocr-lao tesseract-ocr-lat tesseract-ocr-lav tesseract-ocr-lit tesseract-ocr-mal tesseract-ocr-mar tesseract-ocr-mkd
  tesseract-ocr-mlt tesseract-ocr-msa tesseract-ocr-mya tesseract-ocr-nep tesseract-ocr-nld tesseract-ocr-nor tesseract-ocr-ori tesseract-ocr-pan tesseract-ocr-pol tesseract-ocr-por tesseract-ocr-pus
  tesseract-ocr-ron tesseract-ocr-rus tesseract-ocr-san tesseract-ocr-sin tesseract-ocr-slk tesseract-ocr-slk-frak tesseract-ocr-slv tesseract-ocr-spa tesseract-ocr-spa-old tesseract-ocr-sqi tesseract-ocr-srp
  tesseract-ocr-srp-latn tesseract-ocr-swa tesseract-ocr-swe tesseract-ocr-syr tesseract-ocr-tam tesseract-ocr-tel tesseract-ocr-tgk tesseract-ocr-tgl tesseract-ocr-tha tesseract-ocr-tir tesseract-ocr-tur
  tesseract-ocr-uig tesseract-ocr-ukr tesseract-ocr-urd tesseract-ocr-uzb tesseract-ocr-uzb-cyrl tesseract-ocr-vie tesseract-ocr-yid

where the last syllabus (eng, deu) after the hyphen is the preferred language of you choice.

Before you can do this, you have to crop the area of text only and eliminate any symbols or images other readable characters. Tesseract supports a lot of non-latin-based characters sets and languages, such as Hindu, Russian, Asian or even Indonesian.

Tesseract is at least available in the following languages.

Interface: English
Recognition: Afrikaans, Albanian, Arabic, Azerbaijani, Basque, Belarusian, Bengali, Bulgarian, Catalan, Czech, Cherokee, Croatian, Danish, Dutch, English, Esperanto, Estonian, Finnish, French, Galician, German, Greek, Hindi, Hungarian, Indonesian, Italian, Japanese, Kannada, Korean, Latvian, Lithuanian, Malayalam, Macedonian, Maltese, Malay, Norwegian, Polish, Portuguese, Romanian, Russian, Serbian, Slovak, Slovenian, Spanish, Swahili, Swedish, Tagalog, Tamil, Telugu, Thai, Turkish, Ukrainian & Vietnamese (more can be added using included training files)

Version 4 adds LSTM based OCR engine and models for many additional languages and scripts, bringing the total to 116 languages.

https://en.wikipedia.org/wiki/Tesseract_(software)

Tesseract is not supplied with a GUI, but there are many separate projects which provide a GUI for it.

Its is a pure command line tool and can be automatized using C#, Python, or Java.

https://stackoverflow.com/questions/13974645/using-tesseract-from-java

Put the images into the folder sample and run this script.

#!/bin/bash
# PROGRAM=myocr.sh
if [ "$1" ] && [ -e "$1" ]; && [ -e "$2" ]; then
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
  echo "Usage: $0 imagefile [textfile]" >&2
  echo " creates a plain text file with the text found in imagefile" >&2
  exit 1
fi

 

You can run this script on multiple images using this command.

for i in sample/*.jpg;do ./myocr.sh $i result/$(basename $i .jpg) -l eng;done
