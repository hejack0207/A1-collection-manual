# echo(1) - display a line of text

GNU coreutils 8.31, March 2019

```
echo [SHORT-OPTION]... [STRING]...
echo LONG-OPTION
```

<a name="description"></a>

# Description



Echo the STRING(s) to standard output.

* **-n**  
  do not output the trailing newline
* **-e**  
  enable interpretation of backslash escapes
* **-E**  
  disable interpretation of backslash escapes (default)
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

If **-e** is in effect, the following sequences are recognized:

* \e\e  
  backslash
* \ea  
  alert (BEL)
* \eb  
  backspace
* \ec  
  produce no further output
* \ee  
  escape
* \ef  
  form feed
* \en  
  new line
* \er  
  carriage return
* \et  
  horizontal tab
* \ev  
  vertical tab
* \e0NNN  
  byte with octal value NNN (1 to 3 digits)
* \exHH  
  byte with hexadecimal value HH (1 to 2 digits)

NOTE: your shell may have its own version of echo, which usually supersedes
the version described here.  Please refer to your shell's documentation
for details about the options it supports.

<a name="author"></a>

# Author

Written by Brian Fox and Chet Ramey.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/echo&gt;  
or available locally via: info '(coreutils) echo invocation'
