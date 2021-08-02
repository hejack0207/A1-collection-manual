# pwd(1) - print name of current/working directory

GNU coreutils 8.31, March 2019

```
pwd [OPTION]...
```

<a name="description"></a>

# Description



Print the full filename of the current working directory.

* **-L**, **--logical**  
  use PWD from environment, even if it contains symlinks
* **-P**, **--physical**  
  avoid all symlinks
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If no option is specified, **-P** is assumed.

NOTE: your shell may have its own version of pwd, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.

<a name="author"></a>

# Author

Written by Jim Meyering.

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

getcwd(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/pwd&gt;  
or available locally via: info '(coreutils) pwd invocation'
