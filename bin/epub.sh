#!/bin/bash
###epub.sh####
if [[ -z "$1" ]]
then echo "Usage: ./epub.sh book.epub"
exit
fi
if [[ -z "$2" ]]
then COLS=`tput cols`
else
COLS=$2
fi
FILELIST=`zipinfo -1 "$1" | grep -E '\.xml|\.html|\.xhtml' |sort`
TEXT=""
for FILE in $FILELIST
do
TEXT="$TEXT `unzip -caa "$1" "$FILE" | html2text -width $COLS`"
done
echo "$TEXT" | $PAGER

