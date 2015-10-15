#!/bin/bash


### paths

PATH=$PATH:$HOME/bin

## Common Lisp
PATH=$PATH:$HOME/.roswell/bin
PATH=$PATH:$HOME/.cim/bin

## JDK
JAVA_HOME=$HOME/opt/jdk_1.8.0_60
PATH=$PATH:$JAVA_HOME/bin

## node.js
PATH=$PATH:$HOME/npm-global/bin

export PATH

