# mktemp(1) - create a temporary file or directory

GNU coreutils 8.31, March 2019

```
mktemp [OPTION]... [TEMPLATE]
```

<a name="description"></a>

# Description



Create a temporary file or directory, safely, and print its name.
TEMPLATE must contain at least 3 consecutive 'X's in last component.
If TEMPLATE is not specified, use tmp.XXXXXXXXXX, and **--tmpdir** is implied.
Files are created u+rw, and directories u+rwx, minus umask restrictions.

* **-d**, **--directory**  
  create a directory, not a file
* **-u**, **--dry-run**  
  do not create anything; merely print a name (unsafe)
* **-q**, **--quiet**  
  suppress diagnostics about file/dir-creation failure
* **--suffix**=_SUFF_  
  append SUFF to TEMPLATE; SUFF must not contain a slash.
  This option is implied if TEMPLATE does not end in X
* **-p** DIR, **--tmpdir**[=_DIR_]  
  interpret TEMPLATE relative to DIR; if DIR is not
  specified, use $TMPDIR if set, else _/tmp_.  With
  this option, TEMPLATE must not be an absolute name;
  unlike with **-t**, TEMPLATE may contain slashes, but
  mktemp creates only the final component
* **-t**  
  interpret TEMPLATE as a single file name component,
  relative to a directory: $TMPDIR, if set; else the
  directory specified via **-p**; else _/tmp_ [deprecated]
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Jim Meyering and Eric Blake.

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

mkstemp(3), mkdtemp(3), mktemp(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/mktemp&gt;  
or available locally via: info '(coreutils) mktemp invocation'
