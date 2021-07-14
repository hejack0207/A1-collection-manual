# nice(1) - run a program with modified scheduling priority

GNU coreutils 8.31, March 2019

```
nice [OPTION] [COMMAND [ARG]...]
```

<a name="description"></a>

# Description



Run COMMAND with an adjusted niceness, which affects process scheduling.
With no COMMAND, print the current niceness.  Niceness values range from
**-20** (most favorable to the process) to 19 (least favorable to the process).

Mandatory arguments to long options are mandatory for short options too.

* **-n**, **--adjustment**=_N_  
  add integer N to the niceness (default 10)
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

NOTE: your shell may have its own version of nice, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.

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

nice(2), renice(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/nice&gt;  
or available locally via: info '(coreutils) nice invocation'
