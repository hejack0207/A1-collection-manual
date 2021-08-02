# fmt(1) - simple optimal text formatter

GNU coreutils 8.31, March 2019

```
fmt [-WIDTH] [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Reformat each paragraph in the FILE(s), writing to standard output.
The option **-WIDTH** is an abbreviated form of **--width**=_DIGITS_.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-c**, **--crown-margin**  
  preserve indentation of first two lines
* **-p**, **--prefix**=_STRING_  
  reformat only lines beginning with STRING,
  reattaching the prefix to reformatted lines
* **-s**, **--split-only**  
  split long lines, but do not refill
* **-t**, **--tagged-paragraph**  
  indentation of first line different from second
* **-u**, **--uniform-spacing**  
  one space between words, two after sentences
* **-w**, **--width**=_WIDTH_  
  maximum line width (default of 75 columns)
* **-g**, **--goal**=_WIDTH_  
  goal width (default of 93% of width)
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Ross Paterson.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/fmt&gt;  
or available locally via: info '(coreutils) fmt invocation'
