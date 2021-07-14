# fold(1) - wrap each input line to fit in specified width

GNU coreutils 8.31, March 2019

```
fold [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Wrap input lines in each FILE, writing to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-b**, **--bytes**  
  count bytes rather than columns
* **-c**, **--characters**  
  count characters rather than columns
* **-s**, **--spaces**  
  break at spaces
* **-w**, **--width**=_WIDTH_  
  use WIDTH columns instead of 80
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

Full documentation &lt;https://www.gnu.org/software/coreutils/fold&gt;  
or available locally via: info '(coreutils) fold invocation'
