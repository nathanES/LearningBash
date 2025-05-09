#!/bin/bash

makecmd() {
  read target colon sources
  for src in $sources; do
    if [[ $src -nt $target ]]; then
      while read cmd && [ $(grep \t* $cmd) ]; do
        echo "$cmd"
        eval ${cmd#\t}
      done
      break
    fi
  done
}
