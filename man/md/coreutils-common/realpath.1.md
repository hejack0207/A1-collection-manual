# realpath(1) - print the resolved path

GNU coreutils 8.31, March 2019

```
realpath [OPTION]... FILE...
```

<a name="description"></a>

# Description



Print the resolved absolute file name;
all but the last component must exist

* **-e**, **--canonicalize-existing**  
  all components of the path must exist
* **-m**, **--canonicalize-missing**  
  no path components need exist or be a directory
* **-L**, **--logical**  
  resolve '..' components before symlinks
* **-P**, **--physical**  
  resolve symlinks as encountered (default)
* **-q**, **--quiet**  
  suppress most error messages
* **--relative-to**=_DIR_  
  print the resolved path relative to DIR
* **--relative-base**=_DIR_  
  print absolute paths unless paths below DIR
* **-s**, **--strip**, **--no-symlinks**  
  don't expand symlinks
* **-z**, **--zero**  
  end each output line with NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

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

readlink(1), readlink(2), realpath(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/realpath&gt;  
or available locally via: info '(coreutils) realpath invocation'
