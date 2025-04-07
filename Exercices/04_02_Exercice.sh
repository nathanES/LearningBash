#!/bin/bash
outfile=${filename%.pcx}.jpg # looks for pcx on the end of the string. If it's found it's stripped off and the rest of the string is return. If no match, nothing is deleted
for filename do
  pnmfile=${filename%.*}.ppm

  case $filename in
    *.jpg) exit 0;;
    *.tga) tgatoppm $filename > $pnmfile;;
    *.xpm) xpmtoppm $filename > $pnmfile;;
    *.pcx) pcxtoppm $filename > $pnmfile;;
    *.tif) tifftopnm $filename > $pnmfile;;
    *.gif) giftoppm $filename > $pnmfile;;
    *) echo "procfile: $filename is an unknown graphics file."
      exit 1;;
outfile=${pnmfile%.ppm}.new.jpg
pnmtojpeg $pnmfile > $outfile

rm $pnmfile
done
