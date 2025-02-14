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

create_symlink() {
  do_cmd "ln -s" "$1" "$2"
}

copy_file() {
  do_cmd "cp" "$1" "$2"
}

copy_file "$pwd/.prompt-info"
create_symlink "$pwd/bash_scripts.d" "$HOME/.bash_scripts.d"
create_symlink "$HOME/.bash_scripts.d/dot_bash_profile" "$HOME/.bash_profile"
create_symlink "$HOME/.bash_scripts.d/dot_bashrc" "$HOME/.bashrc"
create_symlink "$HOME/.bash_scripts.d/dot_bash_logout" "$HOME/.bash_logout"

create_symlink "$pwd/.tmux.conf"
create_symlink "$pwd/.xremap.config.yaml"
create_symlink "$pwd/.asdfrc"

# ~/bin
mkdir "$HOME/bin"
create_symlink "$pwd/sbcl" "$HOME/bin/"

# ~/code-local
mkdir "$HOME/code-local"
create_symlink "$HOME/code-local/lem/lem" "$HOME/bin/"

# os specific
if [ "$(uname -o)" = "GNU/Linux" ]; then
  create_symlink "$HOME/.bash_scripts.d/dot_bash_profile.linux" "$HOME/.bash_profile.linux"
  create_symlink "$HOME/.bash_scripts.d/dot_bashrc.linux" "$HOME/.bashrc.linux"
elif [ "$(uname -o)" = "Darwin" ]; then
  create_symlink "$HOME/.bash_scripts.d/dot_bash_profile.mac" "$HOME/.bash_profile.mac"
  create_symlink "$HOME/.bash_scripts.d/dot_bashrc.mac" "$HOME/.bashrc.mac"
fi

