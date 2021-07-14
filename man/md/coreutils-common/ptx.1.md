# ptx(1) - produce a permuted index of file contents

GNU coreutils 8.31, March 2019

```
ptx [OPTION]... [INPUT]...   (without -G)
ptx -G [OPTION]... [INPUT [OUTPUT]]
```

<a name="description"></a>

# Description



Output a permuted index, including context, of the words in the input files.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.

* **-A**, **--auto-reference**  
  output automatically generated references
* **-G**, **--traditional**  
  behave more like System V 'ptx'
* **-F**, **--flag-truncation**=_STRING_  
  use STRING for flagging line truncations.
  The default is '/'
* **-M**, **--macro-name**=_STRING_  
  macro name to use instead of 'xx'
* **-O**, **--format**=_roff_  
  generate output as roff directives
* **-R**, **--right-side-refs**  
  put references at right, not counted in **-w**
* **-S**, **--sentence-regexp**=_REGEXP_  
  for end of lines or end of sentences
* **-T**, **--format**=_tex_  
  generate output as TeX directives
* **-W**, **--word-regexp**=_REGEXP_  
  use REGEXP to match each keyword
* **-b**, **--break-file**=_FILE_  
  word break characters in this FILE
* **-f**, **--ignore-case**  
  fold lower case to upper case for sorting
* **-g**, **--gap-size**=_NUMBER_  
  gap size in columns between output fields
* **-i**, **--ignore-file**=_FILE_  
  read ignore word list from FILE
* **-o**, **--only-file**=_FILE_  
  read only word list from this FILE
* **-r**, **--references**  
  first field of each line is a reference
  .HP
  **-t**, **--typeset-mode**               - not implemented -
* **-w**, **--width**=_NUMBER_  
  output width in columns, reference excluded
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="author"></a>

# Author

Written by F. Pinard.

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

Full documentation &lt;https://www.gnu.org/software/coreutils/ptx&gt;  
or available locally via: info '(coreutils) ptx invocation'
