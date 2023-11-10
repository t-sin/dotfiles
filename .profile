#!/bin/bash

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME

OPT=$HOME/opt

export LC_COLLATE="en_US.UTF-8"
export TERM=xterm-256color

export PATH=$PATH:$HOME/.local/bin

# emacs
alias emacsc='emacsclient'
EDITOR=emacsclient
export EDITOR

# qlot

export PATH="/home/grey/.qlot/bin:$PATH"

 #lem

EDITOR=lem
export EDITOR

# paths

PATH=$PATH:$HOME/bin

## yabridge (VST)

PATH=$PATH:/home/grey/.local/share/yabridge

## android studio

PATH=$PATH:$HOME/opt/android-studio/bin

## texlive
PATH=$PATH:/usr/local/texlive/2020/bin/x86_64-linux

## Common Lisp
PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.cim/bin

## Scheme
PATH=$PATH:$HOME/.scheme-env/bin

## golang
export GOROOT=$OPT/go
PATH=$PATH:$GOROOT/bin
export GOPATH=$OPT/gopath
PATH=$PATH:$GOPATH/bin

## nim
PATH=$PATH:$HOME/opt/nim/bin

## Rust
PATH="$HOME/.cargo/bin:$PATH"


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

# DaVinci Resolve
PATH=$PATH:/opt/resolve/bin

# wine
PATH=$PATH:/opt/wine-staging/bin

export PATH


if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
