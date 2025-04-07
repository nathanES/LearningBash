#!/bin/bash

selectd() {
  PS3='directory?'

  dirstack="$DIR_STACK"
  select selection in "${(@s: :)dirstack}"; do # IT split based on : or space
    if [[ $selection ]]; then
      # Remove the selected item from the stack and move it to the front
      DIR_STACK="$selection${dirstack%% *$selection *}"
      DIR_STACK="$DIR_STACK ${dirstack##* $selection }"
      DIR_STACK="${DIR_STACK% }"
      DIR_STACK="${DIR_STACK# }"

      cd "$selection" || echo "Failed to cd into $selection"
      break
    else
      echo 'invalid selection'
    fi
  done
}
