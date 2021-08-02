# chcon(1) - change file SELinux security context

GNU coreutils 8.31, March 2019

```
chcon [OPTION]... CONTEXT FILE...
chcon [OPTION]... [-u USER] [-r ROLE] [-l RANGE] [-t TYPE] FILE...
chcon [OPTION]... --reference=RFILE FILE...
```

<a name="description"></a>

# Description



Change the SELinux security context of each FILE to CONTEXT.
With **--reference**, change the security context of each FILE to that of RFILE.

Mandatory arguments to long options are mandatory for short options too.

* **--dereference**  
  affect the referent of each symbolic link (this is
  the default), rather than the symbolic link itself
* **-h**, **--no-dereference**  
  affect symbolic links instead of any referenced file
* **-u**, **--user**=_USER_  
  set user USER in the target security context
* **-r**, **--role**=_ROLE_  
  set role ROLE in the target security context
* **-t**, **--type**=_TYPE_  
  set type TYPE in the target security context
* **-l**, **--range**=_RANGE_  
  set range RANGE in the target security context
* **--no-preserve-root**  
  do not treat '/' specially (the default)
* **--preserve-root**  
  fail to operate recursively on '/'
* **--reference**=_RFILE_  
  use RFILE's security context rather than specifying
  a CONTEXT value
* **-R**, **--recursive**  
  operate on files and directories recursively
* **-v**, **--verbose**  
  output a diagnostic for every file processed

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

<a name="author"></a>

# Author

Written by Russell Coker and Jim Meyering.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/chcon&gt;  
or available locally via: info '(coreutils) chcon invocation'
