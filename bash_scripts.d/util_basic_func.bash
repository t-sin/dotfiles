#!/bin/bash

# dirname after readlink
function true-dirname() {
  readlink -z -f "$1" | xargs -0 dirname
}

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
