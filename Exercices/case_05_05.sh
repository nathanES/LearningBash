#!/bin/bash
function cd {
  case "$#" in
  0 | 1)
    builtin cd "$1"
    ;;
  2)
    newdir="${PWD//$1/$2}"
    case "$newdir" in
    $PWD)
      echo "bash: cd : bad substiturion" >&2
      return 1
      ;;
    *)
      builtin cd "$newdir"
      ;;
    esac
    ;;
  *)
    echo "bash: cd: wrong arg count" 1>&2
    return 1
    ;;
  esac
}
