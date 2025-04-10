#!/bin/bash
getNdirs()
{
  stackfront=''
  let count=0
  while [[ $count -le $1 ]]; do
    target=${DIR_STACK%${DIR_STACK#*}}
    stackfront="$stackfront$target"
    DIR_STACK=${DIR_STACK#$target}
    let count=count+1
  done

  stackfront=${stackfront%$target}
}
pushd() {
  if [[ $(echo $1 | grep '^[0-9][0-9]*$')]]; then
    # case of pushd +n rotate n-th directory to top

    let num=${1#+}
    getNdirs $num

    DIR_STACK="$dirname ${DIR_STACK:-$PWD''}"
    cd $target
    echo "$DIR_STACK"

  elif [[ -z "$1"]]; then
    # case of pushd without args; swap top two directories
    firstdir=${DIR_STACK%%*}
    DIR_STACK=${DIR_STACK#*}
    seconddir=${DIR_STACK%%*}
    DIR_STACK=${DIR_STACK#*}
    DIR_STACK=$"$seconddir $firstdir $DIR_STACK"

    cd seconddir
  else
    # normal case of pushd dirname
    dirname=$1
    if [[ -n "$dirname" && -d "$dirname" && -x "$dirname"]]; then
      DIR_STACK="$dirname ${DIR_STACK:-$PWD''}"
      echo "$DIR_STACK"
    else
      echo "Still in $PWD"
    fi
  fi
}
popd() {
  if [[ $(echo $1 | grep '^[0-9][0-9]*$')]]; then
    let num ${1#+}
    getNdirs $num
    DIR_STACK="$stackfront$DIR_STACK"

    cd ${DIR_STACK%% *}
    echo "$PWD"
  else
    if [[-n "$DIR_STACK"]]; then
      DIR_STACK=${DIR_STACK#*}
      cd ${DIR_STACK%% *}
      echo "$PWD"
    else
      echo "stack empty, still in $PWD"
    fi
  fi
}
