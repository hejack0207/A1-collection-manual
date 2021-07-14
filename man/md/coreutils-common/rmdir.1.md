# rmdir(1) - remove empty directories

GNU coreutils 8.31, March 2019

```
rmdir [OPTION]... DIRECTORY...
```

<a name="description"></a>

# Description



Remove the DIRECTORY(ies), if they are empty.
.HP
**--ignore-fail-on-non-empty**

* ignore each failure that is solely because a directory
* is non-empty
* **-p**, **--parents**  
  remove DIRECTORY and its ancestors; e.g., 'rmdir **-p** a/b/c' is
  similar to 'rmdir a/b/c a/b a'
* **-v**, **--verbose**  
  output a diagnostic for every directory processed
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by David MacKenzie.

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

rmdir(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/rmdir&gt;  
or available locally via: info '(coreutils) rmdir invocation'
