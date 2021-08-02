# mkfifo(1) - make FIFOs (named pipes)

GNU coreutils 8.31, March 2019

```
mkfifo [OPTION]... NAME...
```

<a name="description"></a>

# Description



Create named pipes (FIFOs) with the given NAMEs.

Mandatory arguments to long options are mandatory for short options too.

* **-m**, **--mode**=_MODE_  
  set file permission bits to MODE, not a=rw - umask
* **-Z**  
  set the SELinux security context to default type
* **--context**[=_CTX_]  
  like **-Z**, or if CTX is specified then set the SELinux
  or SMACK security context to CTX
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

mkfifo(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/mkfifo&gt;  
or available locally via: info '(coreutils) mkfifo invocation'
