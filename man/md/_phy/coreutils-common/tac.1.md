# tac(1) - concatenate and print files in reverse

GNU coreutils 8.31, March 2019

```
tac [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Write each FILE to standard output, last line first.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-b**, **--before**  
  attach the separator before instead of after
* **-r**, **--regex**  
  interpret the separator as a regular expression
* **-s**, **--separator**=_STRING_  
  use STRING as the separator instead of newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Jay Lepreau and David MacKenzie.

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

**rev**(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/tac&gt;  
or available locally via: info '(coreutils) tac invocation'
