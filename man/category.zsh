#!/usr/bin/zsh
setopt -o extendedglob

pattern=${1:?pattern not set}
category=${2}
subdirs=(groff md txt)

for subdir in $subdirs; do
	test -d $subdir/$category || mkdir $subdir/$category
	eval mv $subdir/${pattern}*(.) $subdir/$category/
done
