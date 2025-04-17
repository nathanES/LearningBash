#!/bin/bash

function cleanup {
  if[[ -e $msgfile ]]; then
    mv $msgfile dead.letter
  fi
  trap - INT TERM
  exit
}
trap cleanup INT TERM
msgfile=/tmp/msg$$
cat >$msgfile
# Send the contents of $msgfile to the specified mail address
rm $msgfile

