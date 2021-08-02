# mknod(1) - make block or character special files

GNU coreutils 8.31, March 2019

```
mknod [OPTION]... NAME TYPE [MAJOR MINOR]
```

<a name="description"></a>

# Description



Create the special file NAME of the given TYPE.

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

Both MAJOR and MINOR must be specified when TYPE is b, c, or u, and they
must be omitted when TYPE is p.  If MAJOR or MINOR begins with 0x or 0X,
it is interpreted as hexadecimal; otherwise, if it begins with 0, as octal;
otherwise, as decimal.  TYPE may be:

* b  
  create a block (buffered) special file
* c, u  
  create a character (unbuffered) special file
* p  
  create a FIFO

NOTE: your shell may have its own version of mknod, which usually supersedes
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

mknod(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/mknod&gt;  
or available locally via: info '(coreutils) mknod invocation'
