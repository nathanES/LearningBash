#!/bin/bash
pushd() {
  dirname=$1
  if cd ${dirname:?"Missing directory name."}; then # if cd was succesfull
    DIR_STACK="$dirname ${DIR_STACK:-$PWD''}"
    echo "$DIR_STACK"
  else
    echo "Still in $PWD"
  fi
}
popd() {
  if [[-n "$DIR_STACK"]]; then
    DIR_STACK=${DIR_STACK#*}
    cd ${DIR_STACK%% *}
    echo "$PWD"
  else
    echo "stack empty, still in $PWD"
  fi
}
