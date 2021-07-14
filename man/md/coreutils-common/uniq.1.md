# uniq(1) - report or omit repeated lines

GNU coreutils 8.31, March 2019

```
uniq [OPTION]... [INPUT [OUTPUT]]
```

<a name="description"></a>

# Description



Filter adjacent matching lines from INPUT (or standard input),
writing to OUTPUT (or standard output).

With no options, matching lines are merged to the first occurrence.

Mandatory arguments to long options are mandatory for short options too.

* **-c**, **--count**  
  prefix lines by the number of occurrences
* **-d**, **--repeated**  
  only print duplicate lines, one for each group
* **-D**  
  print all duplicate lines
* **--all-repeated**[=_METHOD_]  
  like **-D**, but allow separating groups
  with an empty line;
  METHOD={none(default),prepend,separate}
* **-f**, **--skip-fields**=_N_  
  avoid comparing the first N fields
* **--group**[=_METHOD_]  
  show all items, separating groups with an empty line;
  METHOD={separate(default),prepend,append,both}
* **-i**, **--ignore-case**  
  ignore differences in case when comparing
* **-s**, **--skip-chars**=_N_  
  avoid comparing the first N characters
* **-u**, **--unique**  
  only print unique lines
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **-w**, **--check-chars**=_N_  
  compare no more than N characters in lines
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

A field is a run of blanks (usually spaces and/or TABs), then non-blank
characters.  Fields are skipped before chars.

Note: 'uniq' does not detect repeated lines unless they are adjacent.
You may want to sort the input first, or use 'sort **-u**' without 'uniq'.
Also, comparisons honor the rules specified by 'LC_COLLATE'.

<a name="author"></a>

# Author

Written by Richard M. Stallman and David MacKenzie.

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

comm(1), join(1), sort(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/uniq&gt;  
or available locally via: info '(coreutils) uniq invocation'
