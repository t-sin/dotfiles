#!/bin/bash

if [ $# -lt 1 ]; then
   cat <<EOF
   reinstall-emacs.sh - replace remacs newer
   usage: reinstall-emacs VERSION

   VERSIONs can be listed by install-emacs.sh

EOF
   exit
fi

LOG_FILE=/var/log/update-emacs.log
VERSION=$1

update_emacs () {
    rm -rf /tmp/emacs-$VERSION
    apt remove emacs-$VERSION -y

    EMACS_TMP_DIR=/tmp /home/user/tmp/dotfiles/install-emacs.sh install master

    emacs --version
}

update_emacs 2>&1 | tee $LOG_FILE
