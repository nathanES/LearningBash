#!/bin/bash
file=$1
shift
for dest in "$@"; do
  cp $file $dest &
done
wait
