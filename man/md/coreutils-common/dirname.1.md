# dirname(1) - strip last component from file name

GNU coreutils 8.31, March 2019

```
dirname [OPTION] NAME...
```

<a name="description"></a>

# Description



Output each NAME with its last non-slash component and trailing slashes
removed; if NAME contains no /'s, output '.' (meaning the current directory).

* **-z**, **--zero**  
  end each output line with NUL, not newline
* **--help**  
  display this help and exit
* **--version**  
  output version information and exit

<a name="examples"></a>

# Examples


* dirname /usr/bin/  
  -&gt; "/usr"
* dirname dir1/str dir2/str  
  -&gt; "dir1" followed by "dir2"
* dirname stdio.h  
  -&gt; "."

<a name="author"></a>

# Author

Written by David MacKenzie and Jim Meyering.

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

basename(1), readlink(1)
  
Full documentation &lt;https://www.gnu.org/software/coreutils/dirname&gt;  
or available locally via: info '(coreutils) dirname invocation'
