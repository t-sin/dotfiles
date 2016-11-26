#!/bin/bash

EMACS_BASE_URL=https://ftp.gnu.org/gnu/emacs
TMP_DIR=$HOME/tmp
EMACS_VERSION_REGEX=emacs-[0-9]{2}\.[0-9][a-z]?

function usage () {
    cat <<EOF
get-emacs - bring emacs into your hand
usage: get-emacs <command> [params...]
!IMPORTANT! run as root to install emacs and dependencies

commands:

         list:
           list available emacs versions.

         install <version> [nogui]:
           install emacs of specified version and its dependent packages.
           when supplied \`nogui\` (or non-empty string), build emacs
           without GUI.

EOF
    exit 1
}

function available_emacs () {
    curl -L $EMACS_BASE_URL 2>/dev/null \
        | sed -E -e 's/.*href="([^"]*)".*/\1/' \
        | sed -nE -e "s/^($EMACS_VERSION_REGEX)\.tar\.gz.*/\1/p" \
        | sort | uniq
}

function install_dependent_packages () {
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

function retrieve_emacs_source () {
    echo retrieving "$1" source...
    EMACS_TARBALL=$(echo $1 | xargs printf '%s.tar.gz')
    EMACS_URL=$(printf "$EMACS_BASE_URL/%s" "$EMACS_TARBALL")

    mkdir -p $TMP_DIR
    pushd $TMP_DIR
    if [ ! -d "$1" ]; then
        curl -L $EMACS_URL > "$EMACS_TARBALL"
        if [ -e "$EMACS_TARBALL" ]; then
            cat "$EMACS_TARBALL" | gzip -d | tar xf -
            rm "$EMACS_TARBALL"
        fi
    fi
    popd
}

function build_and_install_emacs () {
    echo build/install emacs...
    EMACS_VERSION="$1"
    EMACS_SOURCE_PATH="$TMP_DIR/$1"
    NO_GUI=$2

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
    sudo checkinstall -y --pkgname="$EMACS_VERSION"
    popd
}


if [ $# -eq 1 ] && [ "$1" = 'list' ]; then
    available_emacs
elif [ $# -ge 2 ] && [ "$1" = 'install' ]; then
    NO_GUI=$3
    if [[ "$2" =~ ^$EMACS_VERSION_REGEX$ ]]; then
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
