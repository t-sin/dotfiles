#!/bin/bash

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin

export OPT=$HOME/opt
export EDITOR=lem
export LC_COLLATE="en_US.UTF-8"
export TERM=xterm-256color

# Common Lisp

PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.qlot/bin

# Rust

source "$HOME/.cargo/env"

# Java

if [ -d "$HOME/.asdf/plugins/java" ]; then
  . ~/.asdf/plugins/java/set-java-home.bash
fi

# android studio

export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/emulator
export ANDROID_NDK=$ANDROID_HOME/ndk/current

if [ "$(uname -o)" = "GNU/Linux" ]; then
  source ~/.bash_profile.linux
elif [ "$(uname -o)" = "Darwin" ]; then
  source ~/.bash_profile.mac
fi

export PATH

test -r "$HOME/.bashrc" && source "$HOME/.bashrc"
