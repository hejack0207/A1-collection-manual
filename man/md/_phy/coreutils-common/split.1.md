# split(1) - split a file into pieces

GNU coreutils 8.31, March 2019

```
split [OPTION]... [FILE [PREFIX]]
```

<a name="description"></a>

# Description



Output pieces of FILE to PREFIXaa, PREFIXab, ...;
default size is 1000 lines, and default PREFIX is 'x'.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-a**, **--suffix-length**=_N_  
  generate suffixes of length N (default 2)
* **--additional-suffix**=_SUFFIX_  
  append an additional SUFFIX to file names
* **-b**, **--bytes**=_SIZE_  
  put SIZE bytes per output file
* **-C**, **--line-bytes**=_SIZE_  
  put at most SIZE bytes of records per output file
* **-d**  
  use numeric suffixes starting at 0, not alphabetic
* **--numeric-suffixes**[=_FROM_]  
  same as **-d**, but allow setting the start value
* **-x**  
  use hex suffixes starting at 0, not alphabetic
* **--hex-suffixes**[=_FROM_]  
  same as **-x**, but allow setting the start value
* **-e**, **--elide-empty-files**  
  do not generate empty output files with '-n'
* **--filter**=_COMMAND_  
  write to shell COMMAND; file name is $FILE
* **-l**, **--lines**=_NUMBER_  
  put NUMBER lines/records per output file
* **-n**, **--number**=_CHUNKS_  
  generate CHUNKS output files; see explanation below
* **-t**, **--separator**=_SEP_  
  use SEP instead of newline as the record separator;
  '\e0' (zero) specifies the NUL character
* **-u**, **--unbuffered**  
  immediately copy input to output with '-n r/...'
* **--verbose**  
  print a diagnostic just before each
  output file is opened
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

<a name="chunks-may-be"></a>

### CHUNKS may be:


* N  
  split into N files based on size of input
* K/N  
  output Kth of N to stdout
* l/N  
  split into N files without splitting lines/records
* l/K/N  
  output Kth of N to stdout without splitting lines/records
* r/N  
  like 'l' but use round robin distribution
* r/K/N  
  likewise but only output Kth of N to stdout

<a name="author"></a>

# Author

Written by Torbjorn Granlund and Richard M. Stallman.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/split&gt;  
or available locally via: info '(coreutils) split invocation'
