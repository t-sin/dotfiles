#!/bin/bash

function set_prompt() {
  local chroot_color='\[\033[33m\]'
  local username_color='\[\033[00m\]'
  local hostname_color='\[\033[32;1m\]'
  local workdir_color='\[\033[34;1m\]'
  local color_term='\[\033[00m\]'

  local chroot=""
  local user="${USERNAME}"
  local machine="${MACHINENAME}"
  local ps1="${chroot}${user}@${machine}:\w\$ "

  if [ -n "$debian_chroot" ]; then
    chroot="$debian_chroot"
  fi

  if [ "$color_prompt" = "yes" ]; then
    chroot="${chroot_color}${chroot}${color_term}"
    user="${username_color}${user}${color_term}"
    machine="${hostname_color}${machine}${color_term}"
    ps1="${chroot}${user}@${machine}:${workdir_color}\w${color_term}\$ "
  fi
  unset color_prompt force_color_prompt

#  if [[ "$TERM" =~ (xterm*|rxvt*) ]]; then ;
#    #ps1="\[\e]0;${chroot}${user}@${machine}: \w\a\]$ps1"
#  fi

  export PS1="$ps1"
}

function set_color_prompt() {
  color_prompt=yes set_prompt
}

function set_default_prompt() {
  source "$HOME/.prompt-info"
  set_color_prompt
}
