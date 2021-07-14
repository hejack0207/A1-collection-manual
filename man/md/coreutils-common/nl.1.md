# nl(1) - number lines of files

GNU coreutils 8.31, March 2019

```
nl [OPTION]... [FILE]...
```

<a name="description"></a>

# Description



Write each FILE to standard output, with line numbers added.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-b**, **--body-numbering**=_STYLE_  
  use STYLE for numbering body lines
* **-d**, **--section-delimiter**=_CC_  
  use CC for logical page delimiters
* **-f**, **--footer-numbering**=_STYLE_  
  use STYLE for numbering footer lines
* **-h**, **--header-numbering**=_STYLE_  
  use STYLE for numbering header lines
* **-i**, **--line-increment**=_NUMBER_  
  line number increment at each line
* **-l**, **--join-blank-lines**=_NUMBER_  
  group of NUMBER empty lines counted as one
* **-n**, **--number-format**=_FORMAT_  
  insert line numbers according to FORMAT
* **-p**, **--no-renumber**  
  do not reset line numbers for each section
* **-s**, **--number-separator**=_STRING_  
  add STRING after (possible) line number
* **-v**, **--starting-line-number**=_NUMBER_  
  first line number for each section
* **-w**, **--number-width**=_NUMBER_  
  use NUMBER columns for line numbers
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Default options are: **-bt** **-d**'\e:' **-fn** **-hn** **-i1** **-l1** **-n**'rn' **-s**&lt;TAB&gt; **-v1** **-w6**

CC are two delimiter characters used to construct logical page delimiters;
a missing second character implies ':'.

STYLE is one of:

* a  
  number all lines
* t  
  number only nonempty lines
* n  
  number no lines
* pBRE  
  number only lines that contain a match for the basic regular
  expression, BRE

FORMAT is one of:

* ln  
  left justified, no leading zeros
* rn  
  right justified, no leading zeros
* rz  
  right justified, leading zeros

<a name="author"></a>

# Author

Written by Scott Bartram and David MacKenzie.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/nl&gt;  
or available locally via: info '(coreutils) nl invocation'
