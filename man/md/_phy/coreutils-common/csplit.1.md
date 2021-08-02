# csplit(1) - split a file into sections determined by context lines

GNU coreutils 8.31, March 2019

```
csplit [OPTION]... FILE PATTERN...
```

<a name="description"></a>

# Description



Output pieces of FILE separated by PATTERN(s) to files 'xx00', 'xx01', ...,
and output byte counts of each piece to standard output.

Read standard input if FILE is -

Mandatory arguments to long options are mandatory for short options too.

* **-b**, **--suffix-format**=_FORMAT_  
  use sprintf FORMAT instead of %02d
* **-f**, **--prefix**=_PREFIX_  
  use PREFIX instead of 'xx'
* **-k**, **--keep-files**  
  do not remove output files on errors
* **--suppress-matched**  
  suppress the lines matching PATTERN
* **-n**, **--digits**=_DIGITS_  
  use specified number of digits instead of 2
* **-s**, **--quiet**, **--silent**  
  do not print counts of output file sizes
* **-z**, **--elide-empty-files**  
  remove empty output files
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="each-pattern-may-be"></a>

### Each PATTERN may be:


* INTEGER  
  copy up to but not including specified line number
* /REGEXP/[OFFSET]  
  copy up to but not including a matching line
* %REGEXP%[OFFSET]  
  skip to, but not including a matching line
* {INTEGER}  
  repeat the previous pattern specified number of times
* {*}  
  repeat the previous pattern as many times as possible

A line OFFSET is a required '+' or '-' followed by a positive integer.

<a name="author"></a>

# Author

Written by Stuart Kemp and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/csplit&gt;  
or available locally via: info '(coreutils) csplit invocation'
