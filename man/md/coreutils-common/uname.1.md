# uname(1) - print system information

GNU coreutils 8.31, March 2019

```
uname [OPTION]...
```

<a name="description"></a>

# Description



Print certain system information.  With no OPTION, same as **-s**.

* **-a**, **--all**  
  print all information, in the following order,
  except omit **-p** and **-i** if unknown:
* **-s**, **--kernel-name**  
  print the kernel name
* **-n**, **--nodename**  
  print the network node hostname
* **-r**, **--kernel-release**  
  print the kernel release
* **-v**, **--kernel-version**  
  print the kernel version
* **-m**, **--machine**  
  print the machine hardware name
* **-p**, **--processor**  
  print the processor type (non-portable)
* **-i**, **--hardware-platform**  
  print the hardware platform (non-portable)
* **-o**, **--operating-system**  
  print the operating system
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

arch(1), uname(2)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/uname&gt;  
or available locally via: info '(coreutils) uname invocation'
