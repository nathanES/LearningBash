#!/bin/bash

if [[ -z "$1" ]]; then
  echo 'usage:highest filename [-N]'
  exit 1
fi

filename=$1
howmany=${2:-10}
sort -nr $filename | head -$howmany
