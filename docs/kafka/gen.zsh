#!/usr/bin/env -S zsh -il
for f in html/**/*.html; do
	echo $f;
	of=${${f/.html/.md}/html/markdown};
	mkdir -p $(dirname $of);
	pandoc $f -o $of;
done
