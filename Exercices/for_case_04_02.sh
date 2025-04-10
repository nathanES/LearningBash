#!/bin/bash
size=320
width=1
colour="-color black"
usage="Usage: $0 [-s N][-w N][-c S] imagefile..."

while getopts ":s:w:c" opt; do
  case "$opt" in
    s ) size=$OPTARG ;;
    w ) width=$OPTARG ;;
    c ) colour="-color $OPTARG" ;;
    \? ) echo $usage
      exit 1 ;;
  esac
done

shift $(($OPTIND - 1))
if [[ -z "$@"]]; then
  echo $usage
  exit 1
fi

# outfile=${filename%.pcx}.jpg # looks for pcx on the end of the string. If it's found it's stripped off and the rest of the string is return. If no match, nothing is deleted
for filename in "$*"; do
  ppmfile=${filename%.*}.ppm

  case $filename in
    *.jpg ) exit 0 ;;
    *.tga ) tgatoppm $filename > $ppmfile ;;
    *.xpm ) xpmtoppm $filename > $ppmfile ;;
    *.pcx ) pcxtoppm $filename > $ppmfile ;;
    *.tif ) tifftopnm $filename > $ppmfile ;;
    *.gif ) giftoppm $filename > $ppmfile ;;
    * ) echo "procfile: $filename is an unknown graphics file."
      exit 1 ;;
  esac
  outfile=${ppmfile%.ppm}.new.jpg
  pnmscale -quiet -xysize $size $size $ppmfile |
  pnmmargin $colour $width |
  pnmtojpeg > $outfile

  rm $ppmfile
done
