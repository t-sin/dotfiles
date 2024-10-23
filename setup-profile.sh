#!/bin/sh

pwd=$(dirname $0)

debug() {
  if [ "$DEBUG" = "1" ]; then
    echo $@
  fi
}

debug "pwd = $pwd"

do_cmd() {
  cmd="$1"
  file="$2"
  dest="$3"

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
create_symlink "$pwd/.profile"
copy_file "$pwd/.prompt-info" "$HOME/"

# tmux
create_symlink "$pwd/.tmux.conf" "$HOME/"

# for mac
if [ "$(uname -a)" = "Darwin" ]; then
  # bash
  ln -s "$pwd/.profile.mac" "$HOME/"
fi
