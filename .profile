#!/bin/bash

OPT=$HOME/opt

# paths

PATH=$PATH:$HOME/bin

## texlive
PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux

## Common Lisp
PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.cim/bin

## golang
PATH=$PATH:$OPT/go/bin
GOPATH=$OPT/gopath
PATH=$PATH:$GOPATH/bin

## Java
export JAVA_HOME=/usr/local/jdk1.8.0_25
PATH=$PATH:$JAVA_HOME/bin

# Android SDK
#PATH=$PATH:$OPT/android-sdk-linux/tools
#PATH=$PATH:$OPT/android-sdk-linux/platform-tools

export PATH


if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
