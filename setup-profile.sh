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

  if [ -d "$dest" ]; then
    local name="$(basename $file)"
    dest="${dest}${name}"
    debug "dest = $dest"
  fi

  if [ -f "$dest" ]; then
    debug "delete '$dest' because it exists"
    rm "$dest"
  fi

  debug "run command: $cmd $file $dest"
  $cmd "$file" "$dest"
}

create_dir() {
  do_cmd "mkdir -p" "$1" "$2"
}

create_symlink() {
  do_cmd "ln -s" "$1" "$2"
}

copy_file() {
  do_cmd "cp" "$1" "$2"
}

copy_file "$pwd/.prompt-info"
create_symlink "$pwd/.bash_util"
create_symlink "$pwd/.bashrc"
create_symlink "$pwd/.bash_logout"
create_symlink "$pwd/.bash_profile"

create_symlink "$pwd/.tmux.conf"
create_symlink "$pwd/.xremap.config.yaml"

# ~/bin
create_dir "$HOME/bin"
create_symlink "$pwd/sbcl" "$HOME/bin/"

# os specific
if [ "$(uname -o)" = "GNU/Linux" ]; then
  create_symlink "$pwd/.bash_profile.linux"
elif [ "$(uname -o)" = "Darwin" ]; then
  create_symlink "$pwd/.bash_profile.mac"
fi
