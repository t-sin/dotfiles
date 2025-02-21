#!/bin/sh

pwd=$(readlink -z -f "$0" | xargs -0 dirname)

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

  if [ -f "$dest" ]; then
    debug "delete '$dest' because it exists"
    rm "$dest"
  fi

  debug "run command: $cmd $file $dest"
  $cmd "$file" "$dest"
}

create_symlink() {
  do_cmd "ln -sf" "$1" "$2"
}

copy_file() {
  do_cmd "cp -f" "$1" "$2"
}

# basic directories
mkdir -p "$HOME/bin"
mkdir -p "$HOME/opt"
mkdir -p "$HOME/tmp"
mkdir -p "$HOME/code-local"

# bash profiles
copy_file "$pwd/.prompt-info"
[ ! -e "$HOME/.bash_scripts.d" ] && create_symlink "$pwd/bash_scripts.d" "$HOME/.bash_scripts.d"
create_symlink "$HOME/.bash_scripts.d/dot_bash_profile" "$HOME/.bash_profile"
create_symlink "$HOME/.bash_scripts.d/dot_bashrc" "$HOME/.bashrc"
create_symlink "$HOME/.bash_scripts.d/dot_bash_logout" "$HOME/.bash_logout"

case "$(uname -o)" in
  "GNU/Linux")
    create_symlink "$HOME/.bash_scripts.d/dot_bash_profile.linux" "$HOME/.bash_profile.linux"
    create_symlink "$HOME/.bash_scripts.d/dot_bashrc.linux" "$HOME/.bashrc.linux"
    ;;
  "Darwin")
    create_symlink "$HOME/.bash_scripts.d/dot_bash_profile.mac" "$HOME/.bash_profile.mac"
    create_symlink "$HOME/.bash_scripts.d/dot_bashrc.mac" "$HOME/.bashrc.mac"
    ;;
esac

# configurations
create_symlink "$pwd/.tmux.conf"
create_symlink "$pwd/.xremap.config.yaml"
create_symlink "$pwd/.asdfrc"

# ~/bin
create_symlink "$pwd/bin/sbcl" "$HOME/bin/"
create_symlink "$pwd/bin/collect-opt-bins" "$HOME/bin/"
create_symlink "$pwd/bin/compose" "$HOME/bin/"
create_symlink "$HOME/code-local/lem/lem" "$HOME/bin/"

# lem
mkdir -p "$HOME/.lem"
find "$pwd/lem" -name '*.lisp' -exec ln -sf {} "$HOME/.lem/" \;

# os specific
if [ "$(uname -o)" = "GNU/Linux" ]; then
  # autostarts
  create_symlink "$pwd/autostart/uxplay.desktop" "$HOME/.config/autostart/"
  create_symlink "$pwd/autostart/xremap.desktop" "$HOME/.config/autostart/"
elif [ "$(uname -o)" = "Darwin" ]; then
  :
fi
