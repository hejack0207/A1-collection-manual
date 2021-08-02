# mkdir(1) - make directories

GNU coreutils 8.31, March 2019

```
mkdir [OPTION]... DIRECTORY...
```

<a name="description"></a>

# Description



Create the DIRECTORY(ies), if they do not already exist.

Mandatory arguments to long options are mandatory for short options too.

* **-m**, **--mode**=_MODE_  
  set file mode (as in chmod), not a=rwx - umask
* **-p**, **--parents**  
  no error if existing, make parent directories as needed
* **-v**, **--verbose**  
  print a message for each created directory
* **-Z**  
  set SELinux security context of each created directory
  to the default type
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

mkdir(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/mkdir&gt;  
or available locally via: info '(coreutils) mkdir invocation'
