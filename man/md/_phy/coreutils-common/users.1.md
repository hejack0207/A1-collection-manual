# users(1) - print the user names of users currently logged in to the current host

GNU coreutils 8.31, March 2019

```
users [OPTION]... [FILE]
```

<a name="description"></a>

# Description



Output who is currently logged in according to FILE.
If FILE is not specified, use _/var/run/utmp_.  _/var/log/wtmp_ as FILE is common.

* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Joseph Arceneaux and David MacKenzie.

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

getent(1), who(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/users&gt;  
or available locally via: info '(coreutils) users invocation'
