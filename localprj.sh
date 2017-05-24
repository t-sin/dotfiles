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
    local          list asd files in local-projects.
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

local_list () {
    find "$ROSWELL_DIR/local-projects/" -maxdepth 1 -name '*.asd' \
        | sed "s|^$ROSWELL_DIR/local-projects/||"
}

list () {
    find "$CODE_DIR/" -mindepth 2 -maxdepth 2 -name '*.asd' \
        | sed "s|^$CODE_DIR/[^/]*/||"
}

put () {
    asd_file="$1"
    proj_name=$(echo $asd_file | sed s/.asd$//)

    if [ -z $asd_file ]; then
        echo "specify .asd file"
        exit 1
    fi

    if [ ! -e "$CODE_DIR/$proj_name/$asd_file" ]; then
        echo "no such .asd file: '$CODE_DIR/$proj_name/$asd_file'"
        exit 1
    fi

    if [ -e "$ROSWELL_DIR/local-projects/$asd_file" ]; then
        echo "alread exists : '$ROSWELL_DIR/local-projects/$asd_file'"
        exit 1
    fi

    ln -s "$CODE_DIR/$proj_name/$asd_file" "$ROSWELL_DIR/local-projects/$asd_file"
}

del () {
    asd_file="$1"
    proj_name=$(echo $asd_file | sed s/.asd$//)

    if [ -z $asd_file ]; then
        echo "specify .asd file"
        exit 1
    fi

    if [ ! -e "$ROSWELL_DIR/local-projects/$asd_file" ]; then
        echo "no such .asd file: '$CODE_DIR/$proj_name/$asd_file'"
        exit 1
    fi

    unlink "$ROSWELL_DIR/local-projects/$asd_file"
}


if [ $# -lt 1 ]; then
    usage
fi

case "$1" in
    "show" ) show ;;
    "local" ) local_list ;;
    "list" ) list ;;
    "put" ) put $2 ;;
    "del" ) del $2 ;;
    * ) echo "unknow command: $1"
esac
