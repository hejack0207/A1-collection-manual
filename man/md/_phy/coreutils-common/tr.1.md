# tr(1) - translate or delete characters

GNU coreutils 8.31, March 2019

```
tr [OPTION]... SET1 [SET2]
```

<a name="description"></a>

# Description



Translate, squeeze, and/or delete characters from standard input,
writing to standard output.

* **-c**, **-C**, **--complement**  
  use the complement of SET1
* **-d**, **--delete**  
  delete characters in SET1, do not translate
* **-s**, **--squeeze-repeats**  
  replace each sequence of a repeated character
  that is listed in the last specified SET,
  with a single occurrence of that character
* **-t**, **--truncate-set1**  
  first truncate SET1 to length of SET2
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

SETs are specified as strings of characters.  Most represent themselves.
Interpreted sequences are:

* \eNNN  
  character with octal value NNN (1 to 3 octal digits)
* \e\e  
  backslash
* \ea  
  audible BEL
* \eb  
  backspace
* \ef  
  form feed
* \en  
  new line
* \er  
  return
* \et  
  horizontal tab
* \ev  
  vertical tab
* CHAR1-CHAR2  
  all characters from CHAR1 to CHAR2 in ascending order
* [CHAR*]  
  in SET2, copies of CHAR until length of SET1
* [CHAR*REPEAT]  
  REPEAT copies of CHAR, REPEAT octal if starting with 0
* [:alnum:]  
  all letters and digits
* [:alpha:]  
  all letters
* [:blank:]  
  all horizontal whitespace
* [:cntrl:]  
  all control characters
* [:digit:]  
  all digits
* [:graph:]  
  all printable characters, not including space
* [:lower:]  
  all lower case letters
* [:print:]  
  all printable characters, including space
* [:punct:]  
  all punctuation characters
* [:space:]  
  all horizontal or vertical whitespace
* [:upper:]  
  all upper case letters
* [:xdigit:]  
  all hexadecimal digits
* [=CHAR=]  
  all characters which are equivalent to CHAR

Translation occurs if **-d** is not given and both SET1 and SET2 appear.
**-t** may be used only when translating.  SET2 is extended to length of
SET1 by repeating its last character as necessary.  Excess characters
of SET2 are ignored.  Only [:lower:] and [:upper:] are guaranteed to
expand in ascending order; used in SET2 while translating, they may
only be used in pairs to specify case conversion.  **-s** uses the last
specified SET, and occurs after translation or deletion.

<a name="author"></a>

# Author

Written by Jim Meyering.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/tr&gt;  
or available locally via: info '(coreutils) tr invocation'
