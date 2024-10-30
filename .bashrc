#!/bin/bash

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

set_default_prompt

if [ "$(uname -o)" = "GNU/Linux" ]; then
  # asdf
  . "$HOME/.asdf/asdf.sh"
  . "$HOME/.asdf/completions/asdf.bash"
elif [ "$(uname -o)" = "Darwin" ]; then
  # homebrew
  eval $(/opt/homebrew/bin/brew shellenv)
  # asdf
  . "$(brew --prefix asdf)/libexec/asdf.sh"
  . "$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash"
fi
