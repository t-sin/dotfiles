#!/bin/bash

OPT=$HOME/opt

# emacs
alias emacsc='emacsclient'
EDITOR=emacsclient
export EDITOR

# paths

PATH=$PATH:$HOME/bin

## texlive
PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux

## Common Lisp
PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.cim/bin

## golang
export GOROOT=$OPT/go
PATH=$PATH:$GOROOT/bin
export GOPATH=$OPT/gopath
PATH=$PATH:$GOPATH/bin

## nim
PATH=$PATH:$HOME/opt/nim/bin

## erlang
PATH=$PATH:$HOME/opt/otp/bin

## picolisp
PATH=$PATH:$HOME/opt/picolisp
PATH=$PATH:$HOME/opt/picolisp/bin

## lua
PATH=$PATH:$HOME/opt/lua/src/

## JavaScript

PATH=$PATH:$HOME/opt/node/bin

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


## for me

wihi () {
    sed 's/t/ﾋ/g;s/wi/ｳｨ/g;s/er/ﾋｰ/g'
}
