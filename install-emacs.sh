#!/bin/bash

EMACS_SAVANNAH_BASE=https://git.savannah.gnu.org
EMACS_SAVANNAH_TAGS=cgit/emacs.git/refs/tags
EMACS_SAVANNAH_BRANCHES=cgit/emacs.git/refs/heads
EMACS_SAVANNAH_SNAPSHOT=cgit/emacs.git/snapshot
EMACS_VERSION_REGEX=[0-9]{2}\.[0-9][0-9a-z.-]*

if [ -d "$EMACS_TMP_DIR" ] ; then
    TMP_DIR="$EMACS_TMP_DIR"
else
    TMP_DIR=$HOME/tmp
fi


usage () {
    cat <<EOF
get-emacs - bring emacs into your hand
usage: install-emacs <COMMAND> [PARAMS...]

!IMPORTANT! run as root to install emacs and dependencies

COMMANDS:

  list     list available emacs versions (tags).
  branches list all emacs branches.

  tarball <version>
           output tarball URL specified version.
  install <version> [nogui]
           install emacs of specified version and its dependent packages.
           when supplied \`nogui\` (or non-empty string), build emacs
           without GUI.

EOF
    exit 1
}

available_branches () {
    curl -sL $EMACS_SAVANNAH_BASE/$EMACS_SAVANNAH_BRANCHES \
        | grep 'emacs.git/log/?h' \
        | sed -E -e "s|^.+href='/cgit/emacs.git/log/\?h=([^']+).+$|\1|" \
        | sort
}

available_emacs () {
    curl -sL $EMACS_SAVANNAH_BASE/$EMACS_SAVANNAH_TAGS \
        | grep .tar.gz \
        | egrep "$EMACS_SAVANNAH_SNAPSHOT/" \
        | sed -En -e "s|.+$EMACS_SAVANNAH_SNAPSHOT/(emacs-$EMACS_VERSION_REGEX)\.tar\.gz'.+|\1|p" \
        | sort

    echo 'master'
}

tarball_url () {
    echo "$EMACS_SAVANNAH_BASE/$EMACS_SAVANNAH_SNAPSHOT/$1.tar.gz"
}

install_dependent_packages () {
    NO_GUI=$1

    # https://www.emacswiki.org/emacs/EmacsSnapshotAndDebian#toc4
    if [ -n "$NO_GUI" ]; then
	echo install dependent packages without gui
        sudo apt install autoconf automake libtool texinfo build-essential libncurses5-dev libdbus-1-dev libm17n-dev libgnutls-dev libxml2-dev checkinstall
    else
	echo install dependent packages with gui
        sudo apt install autoconf automake libtool texinfo build-essential xorg-dev libgtk2.0-dev libjpeg-dev libncurses5-dev libdbus-1-dev libgif-dev libtiff-dev libm17n-dev libpng12-dev librsvg2-dev libotf-dev libgnutls-dev libxml2-dev checkinstall
    fi
    return 0
}

emacs_name () {
    if [ $1 == master ]; then
        echo emacs-master
    else
        echo $1
    fi
}

retrieve_emacs_source () {
    EMACS_NAME=$(emacs_name "$1")
    EMACS_URL=$(printf "$EMACS_SAVANNAH_BASE/$EMACS_SAVANNAH_SNAPSHOT/%s.tar.gz" "$1")
    echo retrieving $EMACS_NAME source...

    mkdir -p $TMP_DIR
    pushd $TMP_DIR
    if [ ! -d $EMACS_NAME ]; then
        curl -L $EMACS_URL > "$EMACS_NAME.tar.gz"
        if [ -e "$EMACS_NAME.tar.gz" ]; then
            mkdir $EMACS_NAME
            cat "$EMACS_NAME.tar.gz" | gzip -d \
                | tar -xf - --directory=$EMACS_NAME --strip-components=1
            rm "$EMACS_NAME.tar.gz"
        fi
    fi
    popd
}

build_and_install_emacs () {
    echo build/install emacs...
    EMACS_NAME=$(emacs_name "$1")
    EMACS_SOURCE_PATH="$TMP_DIR/$EMACS_NAME"
    EMACS_VERSION=$(cat $EMACS_SOURCE_PATH/configure.* | sed -nE -e 's/AC_INIT\(.+macs, (.+), .+/\1/p')
    NO_GUI=$2
    echo version $EMACS_VERSION

    pushd "$EMACS_SOURCE_PATH"
    if [ -n "$NO_GUI" ]; then
        ./configure \
            --without-x \
            --with-x-toolkit=no \
            --without-xpm \
            --without-jpeg \
            --without-tiff \
            --without-gif \
            --without-png \
            --without-rsvg \
            --without-libotf
    else
        ./configure
    fi
    make
    sudo make install
    popd
}


if [ $# -eq 1 ] && [ "$1" = 'list' ]; then
    available_emacs
elif [ $# -eq 1 ] && [ "$1" = 'branches' ]; then
    available_branches
elif [ $# -ge 2 ] && [ "$1" = 'tarball' ]; then
    tarball_url "$2"
elif [ $# -ge 2 ] && [ "$1" = 'install' ]; then
    NO_GUI=$3
    if [[ "$2" =~ ^(emacs-$EMACS_VERSION_REGEX|master)$ ]]; then
        EMACS_VERSION=$2
        echo "install " $2

        install_dependent_packages "$NO_GUI"
        if [ $? -gt 0 ]; then
            exit 1
        fi
        retrieve_emacs_source $EMACS_VERSION
        if [ $? -gt 0 ]; then
            exit 1
        fi
        build_and_install_emacs $EMACS_VERSION "$NO_GUI"
        exit 0
    else
        usage
    fi
else
    usage
fi
