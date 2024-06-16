#!/bin/bash

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin

export OPT=$HOME/opt
export EDITOR=lem
export LC_COLLATE="en_US.UTF-8"
export TERM=xterm-256color

# java

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64


# Common Lisp

PATH=$PATH:$HOME/.roswell/bin

# Node js

PATH=$PATH:$HOME/.nodebrew/current/bin
PATH=$PATH:$OPT/node/bin

# android studio

export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/emulator
export ANDROID_NDK=$ANDROID_HOME/ndk/current

# yabridge (VST)

PATH=$PATH:/home/grey/.local/share/yabridge

# DaVinci Resolve

PATH=$PATH:/opt/resolve/bin

export PATH

# for mac
if [ $(uname) == "Darwin" ]; then
  . ~/.profile.osx
fi

if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
