# basename(1) - strip directory and suffix from filenames

GNU coreutils 8.31, March 2019

```
basename NAME [SUFFIX]
basename OPTION... NAME...
```

<a name="description"></a>

# Description



Print NAME with any leading directory components removed.
If specified, also remove a trailing SUFFIX.

Mandatory arguments to long options are mandatory for short options too.

* **-a**, **--multiple**  
  support multiple arguments and treat each as a NAME
* **-s**, **--suffix**=_SUFFIX_  
  remove a trailing SUFFIX; implies **-a**
* **-z**, **--zero**  
  end each output line with NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="examples"></a>

# Examples


* basename /usr/bin/sort  
  -&gt; "sort"
* basename include/stdio.h .h  
  -&gt; "stdio"
* basename -s .h include/stdio.h  
  -&gt; "stdio"
* basename -a any/str1 any/str2  
  -&gt; "str1" followed by "str2"

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

dirname(1), readlink(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/basename&gt;  
or available locally via: info '(coreutils) basename invocation'
