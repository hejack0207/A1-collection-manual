#!/usr/bin/zsh

grep -B1 --no-group-separator "^\*\{8,\}" $1
