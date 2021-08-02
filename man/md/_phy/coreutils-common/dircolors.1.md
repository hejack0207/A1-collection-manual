# dircolors(1) - color setup for ls

GNU coreutils 8.31, March 2019

```
dircolors [OPTION]... [FILE]
```

<a name="description"></a>

# Description



Output commands to set the LS_COLORS environment variable.

<a name="determine-format-of-output"></a>

### Determine format of output:


* **-b**, **--sh**, **--bourne-shell**  
  output Bourne shell code to set LS_COLORS
* **-c**, **--csh**, **--c-shell**  
  output C shell code to set LS_COLORS
* **-p**, **--print-database**  
  output defaults
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If FILE is specified, read it to determine which colors to use for which
file types and extensions.  Otherwise, a precompiled database is used.
For details on the format of these files, run 'dircolors **--print-database**'.

<a name="author"></a>

# Author

Written by H. Peter Anvin.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/dircolors&gt;  
or available locally via: info '(coreutils) dircolors invocation'
