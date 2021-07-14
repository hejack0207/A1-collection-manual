# touch(1) - change file timestamps

GNU coreutils 8.31, March 2019

```
touch [OPTION]... FILE...
```

<a name="description"></a>

# Description



Update the access and modification times of each FILE to the current time.

A FILE argument that does not exist is created empty, unless **-c** or **-h**
is supplied.

A FILE argument string of - is handled specially and causes touch to
change the times of the file associated with standard output.

Mandatory arguments to long options are mandatory for short options too.

* **-a**  
  change only the access time
* **-c**, **--no-create**  
  do not create any files
* **-d**, **--date**=_STRING_  
  parse STRING and use it instead of current time
* **-f**  
  (ignored)
* **-h**, **--no-dereference**  
  affect each symbolic link instead of any referenced
  file (useful only on systems that can change the
  timestamps of a symlink)
* **-m**  
  change only the modification time
* **-r**, **--reference**=_FILE_  
  use this file's times instead of current time
* **-t** STAMP  
  use [[CC]YY]MMDDhhmm[.ss] instead of current time
* **--time**=_WORD_  
  change the specified time:
  WORD is access, atime, or use: equivalent to **-a**
  WORD is modify or mtime: equivalent to **-m**
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Note that the **-d** and **-t** options accept different time-date formats.

<a name="date-string"></a>

# Date String


The --date=STRING is a mostly free format human readable date string
such as "Sun, 29 Feb 2004 16:21:42 -0800" or "2004-02-29 16:21:42" or
even "next Thursday".  A date string may contain items indicating
calendar date, time of day, time zone, day of week, relative time,
relative date, and numbers.  An empty string indicates the beginning
of the day.  The date string format is more complex than is easily
documented here but is fully described in the info documentation.

<a name="author"></a>

# Author

Written by Paul Rubin, Arnold Robbins, Jim Kingdon,
David MacKenzie, and Randy Smith.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/touch&gt;  
or available locally via: info '(coreutils) touch invocation'
