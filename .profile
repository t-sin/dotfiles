#!/bin/bash

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin

export OPT=$HOME/opt
export EDITOR=lem
export LC_COLLATE="en_US.UTF-8"
export TERM=xterm-256color

# enable colors for some commands
if [ ! "$(which dircolors)" = "" ]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# enable some aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source "$HOME/.profile.util"
set_default_prompt

# Common Lisp

PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.qlot/bin

# Rust

source "$HOME/.cargo/env"

# Node js

PATH=$PATH:$HOME/.nodebrew/current/bin
PATH=$PATH:$OPT/node/bin

# android studio

export ANDROID_HOME=$HOME/Android/Sdk
PATH=$PATH:$ANDROID_HOME/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/emulator
export ANDROID_NDK=$ANDROID_HOME/ndk/current

if [ "$(uname -o)" = "GNU/Linux" ]; then
  source ~/.profile.linux
elif [ "$(uname -o)" = "Darwin" ]; then
  source ~/.profile.mac
fi

export PATH
