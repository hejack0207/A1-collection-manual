# truncate(1) - shrink or extend the size of a file to the specified size

GNU coreutils 8.31, March 2019

```
truncate OPTION... FILE...
```

<a name="description"></a>

# Description



Shrink or extend the size of each FILE to the specified size

A FILE argument that does not exist is created.

If a FILE is larger than the specified size, the extra data is lost.
If a FILE is shorter, it is extended and the extended part (hole)
reads as zero bytes.

Mandatory arguments to long options are mandatory for short options too.

* **-c**, **--no-create**  
  do not create any files
* **-o**, **--io-blocks**  
  treat SIZE as number of IO blocks instead of bytes
* **-r**, **--reference**=_RFILE_  
  base size on RFILE
* **-s**, **--size**=_SIZE_  
  set or adjust the file size by SIZE bytes
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).
Binary prefixes can be used, too: KiB=K, MiB=M, and so on.

SIZE may also be prefixed by one of the following modifying characters:
'+' extend by, '-' reduce by, '&lt;' at most, '&gt;' at least,
'/' round down to multiple of, '%' round up to multiple of.

<a name="author"></a>

# Author

Written by Padraig Brady.

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

dd(1), truncate(2), ftruncate(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/truncate&gt;  
or available locally via: info '(coreutils) truncate invocation'
