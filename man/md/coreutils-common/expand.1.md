# expand(1) - convert tabs to spaces

GNU coreutils 8.31, March 2019

```
expand [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Convert tabs in each FILE to spaces, writing to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-i**, **--initial**  
  do not convert tabs after non blanks
* **-t**, **--tabs**=_N_  
  have tabs N characters apart, not 8
* **-t**, **--tabs**=_LIST_  
  use comma separated list of tab positions
  The last specified position can be prefixed with '/'
  to specify a tab size to use after the last
  explicitly specified tab stop.  Also a prefix of '+'
  can be used to align remaining tab stops relative to
  the last specified tab stop instead of the first column
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by David MacKenzie.

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

unexpand(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/expand&gt;  
or available locally via: info '(coreutils) expand invocation'
