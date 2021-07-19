#!/usr/bin/zsh

find ../man/txt -size +80k -printf "%s %p\n " | sort -nk1
