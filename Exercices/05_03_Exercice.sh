#!/bin/bash

# FIX : There is an issue with fullpath
recdir() {
  tab=$tab$singletab
  echo "arguments : $@"
  for file in "$@"; do
    echo "file : $file"
    echo -e $tab$file

    fullpath="$basepath/$file"
    [[ -n "$thisfile" ]] && thisfile="$thisfile/$file" || thisfile="$file"
    if [[ -d "$thisfile" ]]; then
      echo "I m a directory > $thisfile"
      (
        basepath="$fullpath"
        recdir $(command ls "$fullpath")
      )
    else
      echo "I m a file > $thisfile"
    fi
    thisfile=${thisfile%/*}
  done

  tab=${tab%"$singletab"}
}
