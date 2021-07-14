# unexpand(1) - convert spaces to tabs

GNU coreutils 8.31, March 2019

```
unexpand [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Convert blanks in each FILE to tabs, writing to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-a**, **--all**  
  convert all blanks, instead of just initial blanks
* **--first-only**  
  convert only leading sequences of blanks (overrides **-a**)
* **-t**, **--tabs**=_N_  
  have tabs N characters apart instead of 8 (enables **-a**)
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

expand(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/unexpand&gt;  
or available locally via: info '(coreutils) unexpand invocation'
