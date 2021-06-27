# chroot(1) - run command or interactive shell with special root directory

GNU coreutils 8.31, March 2019

```
chroot [OPTION] NEWROOT [COMMAND [ARG]...]
chroot OPTION
```

<a name="description"></a>

# Description



Run COMMAND with root directory set to NEWROOT.

* **--groups**=_G\_LIST_  
  specify supplementary groups as g1,g2,..,gN
* **--userspec**=_USER_:GROUP  
  specify user and group (ID or name) to use
* **--skip-chdir**  
  do not change working directory to '/'
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If no command is given, run '"$SHELL" **-i**' (default: '/bin/sh **-i**').

<a name="author"></a>

# Author

Written by Roland McGrath.

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

chroot(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/chroot&gt;  
or available locally via: info '(coreutils) chroot invocation'
