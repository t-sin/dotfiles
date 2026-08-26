#!/usr/bin/env bash
set -eu -o pipefail

prefix=$EMACS_PREFIX
./configure --prefix="$prefix"
