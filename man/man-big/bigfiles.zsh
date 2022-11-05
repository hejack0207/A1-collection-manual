#!/usr/bin/zsh

find ../txt -size +80k -printf "%s %p\n " | sort -nk1
