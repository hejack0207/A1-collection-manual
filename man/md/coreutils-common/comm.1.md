# comm(1) - compare two sorted files line by line

GNU coreutils 8.31, March 2019

```
comm [OPTION]... FILE1 FILE2
```

<a name="description"></a>

# Description



Compare sorted files FILE1 and FILE2 line by line.

When FILE1 or FILE2 (not both) is -, read standard input.

With no options, produce three-column output.  Column one contains
lines unique to FILE1, column two contains lines unique to FILE2,
and column three contains lines common to both files.

* **-1**  
  suppress column 1 (lines unique to FILE1)
* **-2**  
  suppress column 2 (lines unique to FILE2)
* **-3**  
  suppress column 3 (lines that appear in both files)
* **--check-order**  
  check that the input is correctly sorted, even
  if all input lines are pairable
* **--nocheck-order**  
  do not check that the input is correctly sorted
* **--output-delimiter**=_STR_  
  separate columns with STR
* **--total**  
  output a summary
* **-z**, **--zero-terminated**  
  line delimiter is NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

Note, comparisons honor the rules specified by 'LC_COLLATE'.

<a name="examples"></a>

# Examples


* comm -12 file1 file2  
  Print only lines present in both file1 and file2.
* comm -3 file1 file2  
  Print lines in file1 not in file2, and vice versa.

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

join(1), uniq(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/comm&gt;  
or available locally via: info '(coreutils) comm invocation'
