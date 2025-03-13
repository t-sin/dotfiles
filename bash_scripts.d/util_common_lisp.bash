#!/usr/bin/env bash

function sbcl_home() {
  local os="$(uname -o)"
  if [ "$os" = "GNU/Linux" ];then
    os=linux
  elif [ "$os" = "Darwin" ];then
    os=darwin
  fi

  local arch=$(uname -m | tr '_' '-')
  local sbcl_ver=$(ros config 2>&1 | grep 'sbcl-bin.version' | cut -d '=' -f 2)
  local sbcl_home="${HOME}/.roswell/impls/${arch}/${os}/sbcl-bin/${sbcl_ver}"
  echo "${sbcl_home}"
}

function run_sbcl() {
  "$(sbcl_home)/bin/sbcl" $@
}
