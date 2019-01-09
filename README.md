Using Tesseract, you can digitize any kind of image containing printed text.

You can do this very fast a low dpi scanner or camera with a lower resolution.

Your computer will use lots of RAM for the conversion process into a black white image anyway.

You can also improve the recognition rate by compiling Tesseract either with your Radeon GPU or one or multiple your NVIDIA GPU(s).

https://devtalk.nvidia.com/default/topic/995249/gpu-accelerated-libraries/tesseract-with-cuda/

https://github.com/tesseract-ocr/#git%2Fopencl

I have also achieved very good results using a smartphone, a image convert command and tesseract for the CPU in Linux.

To install tesseract in linux, use the folling command:

apt-get install -y tesseract-ocr-all

Before you can do this, you have to crop the area of text only and eliminate any symbols or images other readable characters. Tesseract supports a lot of non-latin-based characters sets and languages, such as Hindu, Russian, Asian or even Indonesian.

Version 4 adds LSTM based OCR engine and models for many additional languages and scripts, bringing the total to 116 languages.
See also:

https://github.com/tesseract-ocr/tesseract/wiki/4.0-with-LSTM

https://en.wikipedia.org/wiki/Tesseract_(software)

Tesseract is not supplied with a GUI, but there are many separate projects which provide a GUI for it.

Its is a pure command line tool and can be automatized using C#, Python, or Java.

https://stackoverflow.com/questions/13974645/using-tesseract-from-java

You can run this script on multiple images using this command.

for i in sample/*.jpg;do ./myocr.sh $i result/$(basename $i .jpg) [language of your choice];done

In my system [Debian 9], the one of the following languages are supported by a short brev:

afr,all,amh,ara,asm,aze,aze-cyrl,bel,ben,bod,bos,bul,cat,ceb,ces,chi-sim,chi-tra,chr,cym,dan,dan-frak,deu,deu-frak,dzo,ell,enm,epo,est,eus,fas,fin,fra,frk,frm,gle,gle-uncial,glg,grc,guj,hat,heb,hin,hrv,hun,iku,ind,isl,ita,ita-old,jav,jpn,kan,kat,kat-old,kaz,khm,kir,kor,kur,lao,lat,lav,lit,mal,mar,mkd,mlt,msa,mya,nep,nld,nor,ori,pan,pol,por,pus,ron,rus,san,sin,slk,slk-frak,slv,spa,spa-old,sqi,srp,srp-latn,swa,swe,syr,tam,tel,tgk,tgl,tha,tir,tur,uig,ukr,urd,uzb,uzb-cyrl,vie,yid
 
To use this version of the script, please download the textcleaner script and make it executable in /usr/sbin.

/usr/bin/convert has to be also installed.

http://www.fmwconcepts.com/imagemagick/textcleaner/index.php


