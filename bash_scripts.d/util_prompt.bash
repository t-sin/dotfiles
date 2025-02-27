#!/bin/bash

function set_prompt() {
  local chroot_color='\[\033[33m\]'
  local username_color='\[\033[00m\]'
  local hostname_color='\[\033[32;1m\]'
  local workdir_color='\[\033[34;1m\]'
  local color_term='\[\033[00m\]'

  local user="${PROMPT_USER}"
  test -z "$user" && user="$1"
  test -z "$user" && user="$USER"

  local host="${PROMPT_HOST}"
  test -z "$host" && host="$2"
  test -z "$host" && host="$HOSTNAME"

  local chroot=""
  test -n "$debian_chroot" && chroot="$debian_chroot"

  local ps1="${chroot}${user}@${host}:\w\$ "

  if [ "$color_prompt" = "yes" ]; then
    chroot="${chroot_color}${chroot}${color_term}"
    user="${username_color}${user}${color_term}"
    host="${hostname_color}${host}${color_term}"
    ps1="${chroot}${user}@${host}:${workdir_color}\w${color_term}\$ "
  fi
  unset color_prompt force_color_prompt

#  if [[ "$TERM" =~ (xterm*|rxvt*) ]]; then ;
#    #ps1="\[\e]0;${chroot}${user}@${machine}: \w\a\]$ps1"
#  fi

  export PS1="$ps1"
}

function set_color_prompt() {
  color_prompt=yes set_prompt "$@"
}

function set_default_prompt() {
  test -r "$HOME/.prompt-info" && . "$HOME/.prompt-info"
  set_color_prompt
}
