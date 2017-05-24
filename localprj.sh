#!/bin/bash

if [ -z "$ROSWELL_DIR" ]; then
    ROSWELL_DIR=$HOME/.roswell
fi

if [ -z "$CODE_DIR" ]; then
    CODE_DIR=$HOME/code
fi

usage() {
    cat <<EOF
localprj.sh COMMAND [PARAMS...]

Maintain roswell local-prpjects. localprj.sh see in ROSWELL_DIR to search roswell's
local projects. Also it see in CODE_DIR to search local codes.

COMMANDS:
    show           show present configuration.
    lclist         list asd files in local-projects.
    list           list available asd files in code directory.
    put ASD_NAME   make symbolic link from ASD_FILE into roswell local-projects.
    del ASD_NAME   unlink ASD_FILE from roswell local-projects.
EOF
    exit 1
}

show () {
    echo "ROSWELL_DIR=$ROSWELL_DIR"
    echo "CODE_DIR=$CODE_DIR"
}

lclist () {
    find "$ROSWELL_DIR/local-projects/" -maxdepth 1 -name '*.asd' \
        | sed "s|^$ROSWELL_DIR/local-projects/||"
}

list () {
    find "$CODE_DIR/" -mindepth 2 -maxdepth 2 -name '*.asd' \
        | sed "s|^$CODE_DIR/[^/]*/||"
}

put () {
    :
}

del () {
    :
}

if [ $# -lt 1 ]; then
    usage
fi

case "$1" in
    "show" ) show ;;
    "lclist" ) lclist ;;
    "list" ) list ;;
    "put" ) put $2 ;;
    "del" ) del $2 ;;
    * ) echo "unknow command: $1"
esac
