#!/bin/bash

IFS=:
for dir in $PATH; do
  if [ -z "$dir"]; then dir=.; fi

  if ! [[ -e "$dir" ]]; then
    echo "$dir doesn't exitst"
  elif ! [[ -d "$dir" ]]; then
    echo "$dir isn't a directory"
  else
    ls -ld $dir
  fi
done
