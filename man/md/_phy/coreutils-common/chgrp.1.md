# chgrp(1) - change group ownership

GNU coreutils 8.31, March 2019

```
chgrp [OPTION]... GROUP FILE...
chgrp [OPTION]... --reference=RFILE FILE...
```

<a name="description"></a>

# Description



Change the group of each FILE to GROUP.
With **--reference**, change the group of each FILE to that of RFILE.

* **-c**, **--changes**  
  like verbose but report only when a change is made
* **-f**, **--silent**, **--quiet**  
  suppress most error messages
* **-v**, **--verbose**  
  output a diagnostic for every file processed
* **--dereference**  
  affect the referent of each symbolic link (this is
  the default), rather than the symbolic link itself
* **-h**, **--no-dereference**  
  affect symbolic links instead of any referenced file
  (useful only on systems that can change the
  ownership of a symlink)
* **--no-preserve-root**  
  do not treat '/' specially (the default)
* **--preserve-root**  
  fail to operate recursively on '/'
* **--reference**=_RFILE_  
  use RFILE's group rather than specifying a
  GROUP value
* **-R**, **--recursive**  
  operate on files and directories recursively

The following options modify how a hierarchy is traversed when the **-R**
option is also specified.  If more than one is specified, only the final
one takes effect.

* **-H**  
  if a command line argument is a symbolic link
  to a directory, traverse it
* **-L**  
  traverse every symbolic link to a directory
  encountered
* **-P**  
  do not traverse any symbolic links (default)
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="examples"></a>

# Examples


* chgrp staff /u  
  Change the group of /u to "staff".
* chgrp -hR staff /u  
  Change the group of /u and subfiles to "staff".

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

chown(1), chown(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/chgrp&gt;  
or available locally via: info '(coreutils) chgrp invocation'
