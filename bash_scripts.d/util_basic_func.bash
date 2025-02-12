#!/bin/bash

# $ first 1 2 3 4
# 1
function first() {
  echo "${@:1:1}"
}

# $ rest 1 2 3 4
# 2 3 4
function rest() {
  echo "${@:2:$#-1}"
}
