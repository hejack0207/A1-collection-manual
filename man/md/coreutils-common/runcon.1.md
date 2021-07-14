# runcon(1) - run command with specified SELinux security context

GNU coreutils 8.31, March 2019

```
runcon CONTEXT COMMAND [args]
runcon [ -c ] [-u USER] [-r ROLE] [-t TYPE] [-l RANGE] COMMAND [args]
```

<a name="description"></a>

# Description

Run COMMAND with completely-specified CONTEXT, or with current or
transitioned security context modified by one or more of LEVEL,
ROLE, TYPE, and USER.

If none of _-c_, _-t_, _-u_, _-r_, or _-l_, is specified,
the first argument is used as the complete context.  Any additional
arguments after _COMMAND_ are interpreted as arguments to the
command.

Note that only carefully-chosen contexts are likely to successfully
run.

Run a program in a different SELinux security context.
With neither CONTEXT nor COMMAND, print the current security context.

Mandatory arguments to long options are mandatory for short options too.

* CONTEXT  
  Complete security context
* **-c**, **--compute**  
  compute process transition context before modifying
* **-t**, **--type**=_TYPE_  
  type (for same role as parent)
* **-u**, **--user**=_USER_  
  user identity
* **-r**, **--role**=_ROLE_  
  role
* **-l**, **--range**=_RANGE_  
  levelrange
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by Russell Coker.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/runcon&gt;  
or available locally via: info '(coreutils) runcon invocation'
