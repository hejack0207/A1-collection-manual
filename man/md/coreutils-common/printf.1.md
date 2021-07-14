# printf(1) - format and print data

GNU coreutils 8.31, March 2019

```
printf FORMAT [ARGUMENT]...
printf OPTION
```

<a name="description"></a>

# Description



Print ARGUMENT(s) according to FORMAT, or execute according to OPTION:

* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

FORMAT controls the output as in C printf.  Interpreted sequences are:

* \e"  
  double quote
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
* \eNNN  
  byte with octal value NNN (1 to 3 digits)
* \exHH  
  byte with hexadecimal value HH (1 to 2 digits)
* \euHHHH  
  Unicode (ISO/IEC 10646) character with hex value HHHH (4 digits)
* \eUHHHHHHHH  
  Unicode character with hex value HHHHHHHH (8 digits)
* %%  
  a single %
* %b  
  ARGUMENT as a string with '\e' escapes interpreted,
  except that octal escapes are of the form \e0 or \e0NNN
* %q  
  ARGUMENT is printed in a format that can be reused as shell input,
  escaping non-printable characters with the proposed POSIX $'' syntax.

and all C format specifications ending with one of diouxXfeEgGcs, with
ARGUMENTs converted to proper type first.  Variable widths are handled.

NOTE: your shell may have its own version of printf, which usually supersedes
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

printf(3)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/printf&gt;  
or available locally via: info '(coreutils) printf invocation'
