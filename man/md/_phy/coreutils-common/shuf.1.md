# shuf(1) - generate random permutations

GNU coreutils 8.31, March 2019

```
shuf [OPTION]... [FILE]
shuf -e [OPTION]... [ARG]...
shuf -i LO-HI [OPTION]...
```

<a name="description"></a>

# Description



Write a random permutation of the input lines to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-e**, **--echo**  
  treat each ARG as an input line
* **-i**, **--input-range**=_LO-HI_  
  treat each number LO through HI as an input line
* **-n**, **--head-count**=_COUNT_  
  output at most COUNT lines
* **-o**, **--output**=_FILE_  
  write result to FILE instead of standard output
* **--random-source**=_FILE_  
  get random bytes from FILE
* **-r**, **--repeat**  
  output lines can be repeated
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Paul Eggert.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/shuf&gt;  
or available locally via: info '(coreutils) shuf invocation'
