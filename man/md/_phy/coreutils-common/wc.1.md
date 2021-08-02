# wc(1) - print newline, word, and byte counts for each file

GNU coreutils 8.31, March 2019

```
wc [OPTION]... [FILE]...
wc [OPTION]... --files0-from=F
```

<a name="description"></a>

# Description



Print newline, word, and byte counts for each FILE, and a total line if
more than one FILE is specified.  A word is a non-zero-length sequence of
characters delimited by white space.

With no FILE, or when FILE is -, read standard input.

The options below may be used to select which counts are printed, always in
the following order: newline, word, character, byte, maximum line length.

* **-c**, **--bytes**  
  print the byte counts
* **-m**, **--chars**  
  print the character counts
* **-l**, **--lines**  
  print the newline counts
* **--files0-from**=_F_  
  read input from the files specified by
  NUL-terminated names in file F;
  If F is - then read names from standard input
* **-L**, **--max-line-length**  
  print the maximum display width
* **-w**, **--words**  
  print the word counts
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Paul Rubin and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/wc&gt;  
or available locally via: info '(coreutils) wc invocation'
