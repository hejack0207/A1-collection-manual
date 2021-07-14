# pinky(1) - lightweight finger

GNU coreutils 8.31, March 2019

```
pinky [OPTION]... [USER]...
```

<a name="description"></a>

# Description



* **-l**  
  produce long format output for the specified USERs
* **-b**  
  omit the user's home directory and shell in long format
* **-h**  
  omit the user's project file in long format
* **-p**  
  omit the user's plan file in long format
* **-s**  
  do short format output, this is the default
* **-f**  
  omit the line of column headings in short format
* **-w**  
  omit the user's full name in short format
* **-i**  
  omit the user's full name and remote host in short format
* **-q**  
  omit the user's full name, remote host and idle time
  in short format
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

A lightweight 'finger' program;  print user information.
The utmp file will be _/var/run/utmp_.

<a name="author"></a>

# Author

Written by Joseph Arceneaux, David MacKenzie, and Kaveh Ghazi.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/pinky&gt;  
or available locally via: info '(coreutils) pinky invocation'
