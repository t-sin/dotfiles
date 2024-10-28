#!/bin/sh

pwd=$(readlink -f $(dirname $0))

debug() {
  if [ "$DEBUG" = "1" ]; then
    echo $@
  fi
}

debug "pwd = $pwd"

do_cmd() {
  local cmd="$1"
  local file="$2"
  local dest="$3"

  if [ "$dest" = "" ]; then
    dest="$HOME/"
  fi

  debug "run command: $cmd $file $dest"
  $cmd "$file" "$dest"
}

create_symlink() {
  do_cmd "ln -s" "$1" "$2"
}

copy_file() {
  do_cmd "cp" "$1" "$2"
}

# bash
create_symlink "$pwd/.profile.util"
create_symlink "$pwd/.profile"
copy_file "$pwd/.prompt-info" "$HOME/"

# tmux
create_symlink "$pwd/.tmux.conf" "$HOME/"

# os specific
if [ "$(uname -o)" = "GNU/Linux" ]; then
  create_symlink "$pwd/.profile.linux"
elif [ "$(uname -o)" = "Darwin" ]; then
  create_symlink "$pwd/.profile.mac"
fi
