#! /bin/bash
WALLPAPERS="/home/josh/Pictures/Backgrounds"
ALIST=( `ls -w1 $WALLPAPERS` )
RANGE=${#ALIST[@]}
let "number = $RANDOM"
let LASTNUM="`cat $WALLPAPERS/.last` + $number"
let "number = $LASTNUM % $RANGE"
echo $number > $WALLPAPERS/.last
feh --bg-fill $WALLPAPERS/${ALIST[$number]}
