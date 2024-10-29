#!/bin/bash

source "$HOME/.bashrc.util"
set_default_prompt

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
