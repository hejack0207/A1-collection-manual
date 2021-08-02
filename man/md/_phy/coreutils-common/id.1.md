# id(1) - print real and effective user and group IDs

GNU coreutils 8.31, March 2019

```
id [OPTION]... [USER]...
```

<a name="description"></a>

# Description



Print user and group information for each specified USER,
or (when USER omitted) for the current user.

* **-a**  
  ignore, for compatibility with other versions
* **-Z**, **--context**  
  print only the security context of the process
* **-g**, **--group**  
  print only the effective group ID
* **-G**, **--groups**  
  print all group IDs
* **-n**, **--name**  
  print a name instead of a number, for **-ugG**
* **-r**, **--real**  
  print the real ID instead of the effective ID, with **-ugG**
* **-u**, **--user**  
  print only the effective user ID
* **-z**, **--zero**  
  delimit entries with NUL characters, not whitespace;
* not permitted in default format
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Without any OPTION, print some useful set of identified information.

<a name="author"></a>

# Author

Written by Arnold Robbins and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/id&gt;  
or available locally via: info '(coreutils) id invocation'
