# paste(1) - merge lines of files

GNU coreutils 8.31, March 2019

```
paste [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Write lines consisting of the sequentially corresponding lines from
each FILE, separated by TABs, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-d**, **--delimiters**=_LIST_  
  reuse characters from LIST instead of TABs
* **-s**, **--serial**  
  paste one file at a time instead of in parallel
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by David M. Ihnat and David MacKenzie.

<a name="reporting-bugs"></a>

# Reporting Bugs

GNU coreutils online help: &lt;https://www.gnu.org/software/coreutils/&gt;  
Report any translation bugs to &lt;https://translationproject.org/team/&gt;

<a name="copyright"></a>

# Copyright

Copyright © 2019 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later &lt;https://gnu.org/licenses/gpl.html&gt;.  
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

<a name="see-also"></a>

# See Also

Full documentation &lt;https://www.gnu.org/software/coreutils/paste&gt;  
or available locally via: info '(coreutils) paste invocation'
