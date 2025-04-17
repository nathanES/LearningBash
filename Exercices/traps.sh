#!/bin/bash

loop() {

  trap "echo 'You hit control-c!'" INT
  trap "echo 'you You tried to kill me!'" TERM

  while true; do
    sleep 60
  done
}
