# cat(1) - concatenate files and print on the standard output

GNU coreutils 8.31, March 2019

```
cat [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

* **-A**, **--show-all**  
  equivalent to **-vET**
* **-b**, **--number-nonblank**  
  number nonempty output lines, overrides **-n**
* **-e**  
  equivalent to **-vE**
* **-E**, **--show-ends**  
  display $ at end of each line
* **-n**, **--number**  
  number all output lines
* **-s**, **--squeeze-blank**  
  suppress repeated empty output lines
* **-t**  
  equivalent to **-vT**
* **-T**, **--show-tabs**  
  display TAB characters as ^I
* **-u**  
  (ignored)
* **-v**, **--show-nonprinting**  
  use ^ and M- notation, except for LFD and TAB
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="examples"></a>

# Examples


* cat f - g  
  Output f's contents, then standard input, then g's contents.
* cat  
  Copy standard input to standard output.

<a name="author"></a>

# Author

Written by Torbjorn Granlund and Richard M. Stallman.

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

**tac**(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/cat&gt;  
or available locally via: info '(coreutils) cat invocation'
