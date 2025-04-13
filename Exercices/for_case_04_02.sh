#!/bin/bash
width=1
colour="-color black"
usage="Usage: $0 [-s N][-w N][-c S] imagefile..."

# Intializing the pipeline components
standardise='|pnmtojpeg-quiet'

while getopts ":s:w:c" opt; do
  case "$opt" in
    S ) shapness='|pnmnlfilt -0.7 0.45' ;;
    s ) size=$OPTARG
      scale='|pnmscale -quiet -xysize $size $size' ;;
    w ) width=$OPTARG
      border='|pnmmargin $colour $width' ;;
    c ) colour="-color $OPTARG"
      border='|pnmmargin $colour $width' ;;
    \? ) echo $usage
      exit 1 ;;
  esac
done

shift $(($OPTIND - 1))

if [[ -z "$@"]]; then
  echo $usage
  exit 1
fi

# Process the input files
# outfile=${filename%.pcx}.jpg # looks for pcx on the end of the string. If it's found it's stripped off and the rest of the string is return. If no match, nothing is deleted
  ppmfile=${filename%.*}.ppm
for filename in "$@"; do
  case $filename in
    *.gif ) convert='giftopnm' ;;
    *.tga ) convert='tgatoppm' ;;
    *.xpm ) convert='xpmtoppm' ;;
    *.pcx ) convert='pcxtoppm' ;;
    *.tif ) convert='tifftopnm' ;;
    *.jpg ) convert='jpegtopnm -quiet' ;;
    * ) echo "$0: Unknown filetype '${filename##*.}"
      exit 1 ;;
  esac
  outfile=${ppmfile%.*}.new.jpg
  eval $convert $filename $scale $border $shapness $standardise > $outfile
done
