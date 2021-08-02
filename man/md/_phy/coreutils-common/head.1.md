# head(1) - output the first part of files

GNU coreutils 8.31, March 2019

```
head [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Print the first 10 lines of each FILE to standard output.
With more than one FILE, precede each with a header giving the file name.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-c**, **--bytes**=_[-]NUM_  
  print the first NUM bytes of each file;
  with the leading '-', print all but the last
  NUM bytes of each file
* **-n**, **--lines**=_[-]NUM_  
  print the first NUM lines instead of the first 10;
  with the leading '-', print all but the last
  NUM lines of each file
* **-q**, **--quiet**, **--silent**  
  never print headers giving file names
* **-v**, **--verbose**  
  always print headers giving file names
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

NUM may have a multiplier suffix:
b 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024,
GB 1000*1000*1000, G 1024*1024*1024, and so on for T, P, E, Z, Y.
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

<a name="author"></a>

# Author

Written by David MacKenzie and Jim Meyering.

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

tail(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/head&gt;  
or available locally via: info '(coreutils) head invocation'
